# Secret WAR Functions Library

# Determine config directory based on context
get_config_dir() {
    # Check if we're in a git repo with local config
    if git rev-parse --git-dir >/dev/null 2>&1; then
        local repo_root="$(git rev-parse --show-toplevel)"
        if [[ -d "$repo_root/.secret-war" ]]; then
            echo "$repo_root/.secret-war"
            return 0
        fi
    fi
    
    # Fallback to global config
    echo "$HOME/.secret-war"
}

# Initialize config directory variable
CONFIG_DIR="$(get_config_dir)"

# Load patterns from config
load_patterns() {
    local patterns=()
    if [[ -f "$CONFIG_DIR/patterns.conf" ]]; then
        while IFS= read -r line; do
            if [[ ! "$line" =~ ^[[:space:]]*# ]] && [[ -n "${line// }" ]]; then
                patterns+=("$line")
            fi
        done < "$CONFIG_DIR/patterns.conf"
    fi
    printf '%s\n' "${patterns[@]}"
}

# Load whitelist files
load_whitelist_files() {
    local files=()
    if [[ -f "$CONFIG_DIR/whitelist-files.conf" ]]; then
        while IFS= read -r line; do
            if [[ ! "$line" =~ ^[[:space:]]*# ]] && [[ -n "${line// }" ]]; then
                files+=("$line")
            fi
        done < "$CONFIG_DIR/whitelist-files.conf"
    fi
    printf '%s\n' "${files[@]}"
}

# Load whitelist patterns
load_whitelist_patterns() {
    local patterns=()
    if [[ -f "$CONFIG_DIR/whitelist-patterns.conf" ]]; then
        while IFS= read -r line; do
            if [[ ! "$line" =~ ^[[:space:]]*# ]] && [[ -n "${line// }" ]]; then
                patterns+=("$line")
            fi
        done < "$CONFIG_DIR/whitelist-patterns.conf"
    fi
    printf '%s\n' "${patterns[@]}"
}

# Check if file should be whitelisted
is_file_whitelisted() {
    local file="$1"
    local whitelist_files
    readarray -t whitelist_files < <(load_whitelist_files)
    
    for pattern in "${whitelist_files[@]}"; do
        if [[ "$file" == *"$pattern"* ]]; then
            return 0
        fi
    done
    return 1
}

# Check if match should be whitelisted
is_match_whitelisted() {
    local match="$1"
    local whitelist_patterns
    readarray -t whitelist_patterns < <(load_whitelist_patterns)
    
    for pattern in "${whitelist_patterns[@]}"; do
        if echo "$match" | grep -qE "$pattern"; then
            return 0
        fi
    done
    return 1
}

# Get staged files
get_staged_files() {
    git diff --cached --name-only --diff-filter=ACM | grep -v -E '\.(gitignore|gitattributes)$|\.git/|\.vscode/|\.idea/|\.secret-war/' || true
}
