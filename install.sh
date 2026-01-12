#!/usr/bin/env bash
#
# Claude Code Config Installer
# Copies configuration files to ~/.claude/
#
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Flags
FORCE=false

log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[OK]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Track installation stats
INSTALLED=0
SKIPPED=0
FAILED=0

# Parse command line arguments
parse_args() {
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --force|-f)
                FORCE=true
                shift
                ;;
            --help|-h)
                echo "Usage: $0 [OPTIONS]"
                echo ""
                echo "Options:"
                echo "  --force, -f    Overwrite existing files without prompting"
                echo "  --help, -h     Show this help message"
                exit 0
                ;;
            *)
                log_error "Unknown option: $1"
                exit 1
                ;;
        esac
    done
}

# Check dependencies
check_dependencies() {
    local missing=()

    if ! command -v jq &>/dev/null; then
        missing+=("jq (required for settings.json merge)")
    fi

    if ! command -v python3 &>/dev/null; then
        missing+=("python3 (required for hooks)")
    fi

    if [[ ${#missing[@]} -gt 0 ]]; then
        log_warn "Missing optional dependencies:"
        for dep in "${missing[@]}"; do
            echo "  - $dep"
        done
        echo ""
        log_info "Install them for full functionality, or press Enter to continue anyway."
        read -rp "Continue? [Y/n]: " response
        if [[ "$response" =~ ^[Nn] ]]; then
            log_error "Installation aborted."
            exit 1
        fi
    fi
}

# Prompt for user action when file exists
# Returns: "skip", "overwrite", or "merge"
prompt_action() {
    local dest="$1"

    if [[ "$FORCE" == true ]]; then
        echo "overwrite"
        return
    fi

    echo ""
    log_warn "File already exists: $dest"
    echo "  [s] Skip - keep existing file"
    echo "  [o] Overwrite - replace with new version"
    echo "  [m] Merge - try to combine (manual review needed)"
    echo ""
    read -rp "Choice [s/o/m]: " choice
    case "$choice" in
        o|O) echo "overwrite" ;;
        m|M) echo "merge" ;;
        *)   echo "skip" ;;
    esac
}

# Install a single file
install_file() {
    local src="$1"
    local dest="$2"
    local dest_dir
    dest_dir="$(dirname "$dest")"

    # Create destination directory if needed
    mkdir -p "$dest_dir"

    if [[ -f "$dest" ]]; then
        action=$(prompt_action "$dest")
        case "$action" in
            skip)
                log_info "Skipped: $dest"
                ((SKIPPED++))
                return 0
                ;;
            overwrite)
                cp "$src" "$dest"
                log_success "Overwrote: $dest"
                ((INSTALLED++))
                ;;
            merge)
                # Create backup and copy new file
                cp "$dest" "${dest}.backup"
                cp "$src" "${dest}.new"
                log_warn "Created ${dest}.new and ${dest}.backup - manual merge needed"
                ((SKIPPED++))
                ;;
        esac
    else
        cp "$src" "$dest"
        log_success "Installed: $dest"
        ((INSTALLED++))
    fi
}

# Install a directory recursively
install_dir() {
    local src_dir="$1"
    local dest_dir="$2"
    local pattern="${3:-*}"

    if [[ ! -d "$src_dir" ]]; then
        log_warn "Source directory not found: $src_dir"
        return 1
    fi

    find "$src_dir" -type f -name "$pattern" | while read -r src; do
        local relative="${src#$src_dir/}"
        local dest="$dest_dir/$relative"
        install_file "$src" "$dest"
    done
}

# Merge settings.json hooks using jq
merge_settings() {
    local settings_file="$CLAUDE_DIR/settings.json"
    local example_file="$SCRIPT_DIR/settings.json.example"

    if [[ ! -f "$example_file" ]]; then
        log_warn "settings.json.example not found, skipping hook wiring"
        return 0
    fi

    if [[ ! -f "$settings_file" ]]; then
        # No existing settings, just copy
        cp "$example_file" "$settings_file"
        log_success "Created: $settings_file"
        ((INSTALLED++))
        return 0
    fi

    # Existing settings.json found - attempt merge
    if ! command -v jq &>/dev/null; then
        log_warn "jq not installed - cannot merge settings.json"
        log_info "Please manually merge hooks from settings.json.example"
        cat "$example_file"
        echo ""
        return 0
    fi

    # Check if existing settings already has hooks
    if jq -e '.hooks' "$settings_file" &>/dev/null; then
        if [[ "$FORCE" == true ]]; then
            # Force mode: replace hooks entirely
            local merged
            merged=$(jq -s '.[0] * .[1]' "$settings_file" "$example_file")
            echo "$merged" > "$settings_file"
            log_success "Merged hooks into: $settings_file"
            ((INSTALLED++))
        else
            log_warn "Existing settings.json already has hooks configured"
            echo ""
            echo "Options:"
            echo "  [s] Skip - keep existing hooks unchanged"
            echo "  [m] Merge - combine hooks (may create duplicates)"
            echo "  [r] Replace - overwrite hooks with new version"
            echo ""
            read -rp "Choice [s/m/r]: " choice
            case "$choice" in
                m|M)
                    # Deep merge: combine hook arrays
                    local merged
                    merged=$(jq -s '
                        .[0] as $existing |
                        .[1] as $new |
                        $existing * {
                            hooks: (
                                ($existing.hooks // {}) as $eh |
                                ($new.hooks // {}) as $nh |
                                ($eh | keys) + ($nh | keys) | unique |
                                map(. as $k | {($k): (($eh[$k] // []) + ($nh[$k] // []))}) |
                                add
                            )
                        }
                    ' "$settings_file" "$example_file")
                    echo "$merged" > "$settings_file"
                    log_success "Merged hooks into: $settings_file"
                    ((INSTALLED++))
                    ;;
                r|R)
                    local merged
                    merged=$(jq -s '.[0] * .[1]' "$settings_file" "$example_file")
                    echo "$merged" > "$settings_file"
                    log_success "Replaced hooks in: $settings_file"
                    ((INSTALLED++))
                    ;;
                *)
                    log_info "Skipped: $settings_file"
                    ((SKIPPED++))
                    ;;
            esac
        fi
    else
        # No existing hooks - safe to add
        local merged
        merged=$(jq -s '.[0] * .[1]' "$settings_file" "$example_file")
        echo "$merged" > "$settings_file"
        log_success "Added hooks to: $settings_file"
        ((INSTALLED++))
    fi
}

# Make hooks executable
make_hooks_executable() {
    local hooks_dir="$CLAUDE_DIR/hooks"
    if [[ -d "$hooks_dir" ]]; then
        find "$hooks_dir" -type f \( -name "*.sh" -o -name "*.py" \) -exec chmod +x {} \;
        log_success "Made hooks executable"
    fi
}

# Migrate skills from kebab-case to TitleCase
migrate_skills() {
    local skills_dir="$CLAUDE_DIR/skills"

    # Map of old kebab-case names to new TitleCase names
    declare -A SKILL_MIGRATION=(
        ["brainstorming"]="Brainstorming"
        ["compound"]="Compound"
        ["dispatching-parallel-agents"]="DispatchingParallelAgents"
        ["executing-plans"]="ExecutingPlans"
        ["finishing-a-development-branch"]="FinishingDevelopmentBranch"
        ["planning-with-files"]="PlanningWithFiles"
        ["react-useeffect"]="ReactUseEffect"
        ["receiving-code-review"]="ReceivingCodeReview"
        ["requesting-code-review"]="RequestingCodeReview"
        ["review"]="Review"
        ["subagent-driven-development"]="SubagentDrivenDevelopment"
        ["systematic-debugging"]="SystematicDebugging"
        ["test-driven-development"]="TestDrivenDevelopment"
        ["using-git-worktrees"]="UsingGitWorktrees"
        ["using-workflows"]="UsingWorkflows"
        ["verification-before-completion"]="VerificationBeforeCompletion"
        ["writing-plans"]="WritingPlans"
        ["writing-skills"]="WritingSkills"
    )

    local migrated=0
    for old_name in "${!SKILL_MIGRATION[@]}"; do
        local old_path="$skills_dir/$old_name"
        local new_name="${SKILL_MIGRATION[$old_name]}"
        local new_path="$skills_dir/$new_name"

        if [[ -d "$old_path" && ! -d "$new_path" ]]; then
            # Old exists, new doesn't - just remove old (new will be installed)
            rm -rf "$old_path"
            log_info "Removed legacy skill: $old_name"
            ((migrated++))
        elif [[ -d "$old_path" && -d "$new_path" ]]; then
            # Both exist - remove old, keep new
            rm -rf "$old_path"
            log_info "Cleaned up duplicate: $old_name"
            ((migrated++))
        elif [[ -d "$old_path" ]]; then
            # Old exists - remove it
            rm -rf "$old_path"
            log_info "Removed legacy skill: $old_name"
            ((migrated++))
        fi
    done

    if [[ $migrated -gt 0 ]]; then
        log_success "Migrated $migrated legacy skill directories"
    fi
}

main() {
    parse_args "$@"

    echo ""
    echo "=========================================="
    echo "  Claude Code Config Installer"
    echo "=========================================="
    echo ""
    log_info "Source: $SCRIPT_DIR"
    log_info "Destination: $CLAUDE_DIR"
    if [[ "$FORCE" == true ]]; then
        log_info "Mode: Force (overwrite without prompting)"
    fi
    echo ""

    # Check dependencies
    check_dependencies

    # Create base directory
    mkdir -p "$CLAUDE_DIR"

    # Install components
    log_info "Installing rules..."
    install_dir "$SCRIPT_DIR/rules" "$CLAUDE_DIR/rules" "*.md"

    log_info "Migrating legacy skills..."
    migrate_skills

    log_info "Installing skills..."
    install_dir "$SCRIPT_DIR/skills" "$CLAUDE_DIR/skills" "*.md"

    log_info "Installing agents..."
    install_dir "$SCRIPT_DIR/agents" "$CLAUDE_DIR/agents" "*.md"

    log_info "Installing prompts..."
    install_dir "$SCRIPT_DIR/prompts" "$CLAUDE_DIR/prompts" "*.md"

    log_info "Installing commands..."
    install_dir "$SCRIPT_DIR/commands" "$CLAUDE_DIR/commands" "*.md"

    log_info "Installing hooks..."
    install_dir "$SCRIPT_DIR/hooks" "$CLAUDE_DIR/hooks" "*.py"
    install_dir "$SCRIPT_DIR/hooks" "$CLAUDE_DIR/hooks" "*.sh"

    log_info "Installing config..."
    install_dir "$SCRIPT_DIR/config" "$CLAUDE_DIR/config" "*.json"

    log_info "Installing CLAUDE.md..."
    install_file "$SCRIPT_DIR/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"

    # Make hooks executable
    make_hooks_executable

    # Handle settings.json
    log_info "Configuring settings.json..."
    merge_settings

    # Summary
    echo ""
    echo "=========================================="
    echo "  Installation Complete"
    echo "=========================================="
    echo ""
    log_info "Installed: $INSTALLED files"
    log_info "Skipped: $SKIPPED files"
    if [[ $FAILED -gt 0 ]]; then
        log_error "Failed: $FAILED files"
    fi
    echo ""
    log_info "Restart Claude Code for changes to take effect."
    echo ""
}

main "$@"
