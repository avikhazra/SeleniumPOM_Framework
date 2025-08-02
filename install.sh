#!/bin/bash

# Secret WAR - Advanced Git Pre-commit Security Scanner
# Installation Script
# "Dread it, Run from it. Destiny Still arrives"
# Version: 1.0.0

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.secret-war"
INSTALL_TYPE=""
VERBOSE=false
FORCE_INSTALL=false
VERSION="1.0.0"

# Installation banner
show_banner() {
    clear
    echo -e "${PURPLE}${BOLD}"
    cat << 'EOF'
   ██████  ███████  ██████ ██████  ███████ ████████     ██     ██  █████  ████████ 
  ██       ██      ██      ██   ██ ██         ██        ██     ██ ██   ██ ██     ██
  ██████   █████   ██      ██████  █████      ██        ██  █  ██ ███████ ██████  
       ██  ██      ██      ██   ██ ██         ██        ██ ███ ██ ██   ██ ██   ██ 
  ██████   ███████  ██████ ██   ██ ███████    ██         ███ ███  ██   ██ ██   ██ 
                                                                                    
                    Advanced Git Pre-commit Security Scanner
                         "Dread it, Run from it. Destiny Still arrives"
                                     Installer v${VERSION}
EOF
    echo -e "${NC}"
    echo -e "${CYAN}🛡️  Protecting your repositories from security vulnerabilities${NC}"
    echo -e "${CYAN}⚡ 8-thread parallel processing | 50+ security patterns | HTML reports${NC}"
    echo ""
}

# Print colored output
print_info() { echo -e "${BLUE}ℹ️  $1${NC}"; }
print_success() { echo -e "${GREEN}✅ $1${NC}"; }
print_warning() { echo -e "${YELLOW}⚠️  $1${NC}"; }
print_error() { echo -e "${RED}❌ $1${NC}"; }
print_step() { echo -e "${PURPLE}🔄 $1${NC}"; }

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check system requirements
check_requirements() {
    print_step "Checking system requirements..."
    
    local missing_deps=()
    
    # Check required commands
    if ! command_exists git; then
        missing_deps+=("git")
    fi
    
    if ! command_exists grep; then
        missing_deps+=("grep")
    fi
    
    if ! command_exists sed; then
        missing_deps+=("sed")
    fi
    
    if ! command_exists awk; then
        missing_deps+=("awk")
    fi
    
    if ! command_exists file; then
        missing_deps+=("file")
    fi
    
    if [[ ${#missing_deps[@]} -gt 0 ]]; then
        print_error "Missing required dependencies: ${missing_deps[*]}"
        echo ""
        echo "Please install the missing dependencies and run the installer again."
        exit 1
    fi
    
    # Check Git version
    local git_version
    git_version=$(git --version | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' | head -1)
    local git_major
    git_major=$(echo "$git_version" | cut -d. -f1)
    local git_minor
    git_minor=$(echo "$git_version" | cut -d. -f2)
    
    if [[ $git_major -lt 2 ]] || [[ $git_major -eq 2 && $git_minor -lt 9 ]]; then
        print_warning "Git version $git_version detected. Recommended: 2.9 or higher"
    fi
    
    print_success "System requirements satisfied"
}

# Show installation options menu
show_menu() {
    echo -e "${BOLD}${CYAN}Installation Options:${NC}"
    echo ""
    echo -e "${GREEN}1)${NC} 🌍 Global Installation    - Protect all repositories (Recommended)"
    echo -e "${GREEN}2)${NC} 📁 Local Installation     - Protect current repository only"
    echo -e "${GREEN}3)${NC} ⚙️  Advanced Installation  - Custom configuration"
    echo -e "${GREEN}4)${NC} 🔄 Update Installation    - Update existing installation"
    echo -e "${GREEN}5)${NC} 🗑️  Uninstall             - Remove Secret WAR"
    echo -e "${GREEN}6)${NC} ❓ Help                   - Show usage information"
    echo -e "${GREEN}0)${NC} 🚪 Exit                   - Exit installer"
    echo ""
}

# Get user choice
get_user_choice() {
    local choice
    while true; do
        echo -ne "${CYAN}Choose an option [1-6, 0 to exit]: ${NC}"
        read -r choice
        
        case $choice in
            1)
                INSTALL_TYPE="global"
                break
                ;;
            2) 
                INSTALL_TYPE="local"
                break
                ;;
            3)
                INSTALL_TYPE="advanced"
                break
                ;;
            4)
                INSTALL_TYPE="update"
                break
                ;;
            5)
                INSTALL_TYPE="uninstall"
                break
                ;;
            6)
                show_help
                continue
                ;;
            0)
                print_info "Installation cancelled by user"
                exit 0
                ;;
            *)
                print_error "Invalid choice. Please select 1-6 or 0 to exit."
                continue
                ;;
        esac
    done
}

# Show help information
show_help() {
    echo ""
    echo -e "${BOLD}${CYAN}Secret WAR Installation Help${NC}"
    echo ""
    echo -e "${YELLOW}Installation Types:${NC}"
    echo ""
    echo -e "${GREEN}Global Installation:${NC}"
    echo "  • Installs hooks for all repositories (current and future)"
    echo "  • Uses Git template directory (~/.git-templates)"
    echo "  • Automatically applies to new repositories via 'git init' or 'git clone'"
    echo "  • Recommended for most users"
    echo ""
    echo -e "${GREEN}Local Installation:${NC}"
    echo "  • Installs hook only in current repository"
    echo "  • Must be run from within a Git repository"
    echo "  • Useful for testing or repository-specific requirements"
    echo ""
    echo -e "${GREEN}Advanced Installation:${NC}"
    echo "  • Custom configuration options"
    echo "  • Choose thread count, patterns, and whitelisting"
    echo "  • Custom report directory and configuration"
    echo ""
    echo -e "${YELLOW}Command Line Options:${NC}"
    echo "  --global          Global installation"
    echo "  --local           Local installation"
    echo "  --advanced        Advanced installation"
    echo "  --update          Update existing installation"
    echo "  --uninstall       Remove Secret WAR"
    echo "  --force           Force installation (overwrite existing)"
    echo "  --verbose         Verbose output"
    echo "  --help            Show this help"
    echo ""
    echo -e "${YELLOW}Examples:${NC}"
    echo "  ./install.sh --global          # Quick global install"
    echo "  ./install.sh --local --force   # Force local install"
    echo "  ./install.sh --advanced        # Interactive advanced setup"
    echo ""
    read -p "Press Enter to continue..."
    echo ""
}

# Parse command line arguments
parse_arguments() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            --global)
                INSTALL_TYPE="global"
                shift
                ;;
            --local)
                INSTALL_TYPE="local"
                shift
                ;;
            --advanced)
                INSTALL_TYPE="advanced"
                shift
                ;;
            --update)
                INSTALL_TYPE="update"
                shift
                ;;
            --uninstall)
                INSTALL_TYPE="uninstall"
                shift
                ;;
            --force)
                FORCE_INSTALL=true
                shift
                ;;
            --verbose)
                VERBOSE=true
                shift
                ;;
            --help|-h)
                show_help
                exit 0
                ;;
            *)
                print_error "Unknown option: $1"
                echo "Use --help for usage information"
                exit 1
                ;;
        esac
    done
}

# Create configuration directory and files
setup_config() {
    print_step "Setting up configuration..."
    
    mkdir -p "$CONFIG_DIR" "$CONFIG_DIR/reports"
    
    # Copy main script
    if [[ -f "$SCRIPT_DIR/secret-war.sh" ]]; then
        cp "$SCRIPT_DIR/secret-war.sh" "$CONFIG_DIR/"
        chmod +x "$CONFIG_DIR/secret-war.sh"
    elif [[ -f "$SCRIPT_DIR/paste.txt" ]]; then
        # If using the provided script content
        cp "$SCRIPT_DIR/paste.txt" "$CONFIG_DIR/secret-war.sh"
        chmod +x "$CONFIG_DIR/secret-war.sh"
    else
        print_error "Secret WAR main script not found!"
        exit 1
    fi
    
    # Create default patterns file if it doesn't exist
    if [[ ! -f "$CONFIG_DIR/patterns.conf" ]] || [[ "$FORCE_INSTALL" == true ]]; then
        create_patterns_config
    fi
    
    # Create whitelist files if they don't exist
    if [[ ! -f "$CONFIG_DIR/whitelist-files.conf" ]] || [[ "$FORCE_INSTALL" == true ]]; then
        create_whitelist_files_config
    fi
    
    if [[ ! -f "$CONFIG_DIR/whitelist-patterns.conf" ]] || [[ "$FORCE_INSTALL" == true ]]; then
        create_whitelist_patterns_config
    fi
    
    # Create functions library
    create_functions_library
    
    print_success "Configuration setup completed"
}

# Create patterns configuration
create_patterns_config() {
    cat > "$CONFIG_DIR/patterns.conf" << 'EOF'
# Secret WAR Pattern Configuration
# Add one regex pattern per line
# Lines starting with # are comments

# API Keys and Tokens
[a-zA-Z0-9_-]*api[_-]?key[a-zA-Z0-9_-]*\s*[:=]\s*['"'"'"][a-zA-Z0-9_-]{8,}['"'"'"]
[a-zA-Z0-9_-]*token[a-zA-Z0-9_-]*\s*[:=]\s*['"'"'"][a-zA-Z0-9_-]{8,}['"'"'"]
[a-zA-Z0-9_-]*secret[a-zA-Z0-9_-]*\s*[:=]\s*['"'"'"][a-zA-Z0-9_-]{8,}['"'"'"]

# AWS Credentials
AKIA[0-9A-Z]{16}
aws_access_key_id\s*[:=]\s*['"'"'"]?[A-Z0-9]{20}['"'"'"]?
aws_secret_access_key\s*[:=]\s*['"'"'"]?[A-Za-z0-9/+=]{40}['"'"'"]?

# Google API Keys
AIza[0-9A-Za-z_-]{35}
ya29\.[0-9A-Za-z_-]+

# GitHub Tokens
ghp_[a-zA-Z0-9]{36}
gho_[a-zA-Z0-9]{36}
ghu_[a-zA-Z0-9]{36}
ghs_[a-zA-Z0-9]{36}
ghr_[a-zA-Z0-9]{36}

# Private Keys
-----BEGIN\s+(RSA\s+|DSA\s+|EC\s+|OPENSSH\s+)?PRIVATE\s+KEY-----
-----BEGIN\s+PGP\s+PRIVATE\s+KEY\s+BLOCK-----

# Database Connection Strings
(mongodb|mysql|postgresql|oracle|sqlserver)://[a-zA-Z0-9_.-]+:[a-zA-Z0-9_.-]+@[a-zA-Z0-9_.-]+
jdbc:[a-zA-Z0-9]+://[a-zA-Z0-9_.-]+:[0-9]+/[a-zA-Z0-9_.-]+

# JWT Tokens
eyJ[a-zA-Z0-9_-]*\.[a-zA-Z0-9_-]*\.[a-zA-Z0-9_-]*

# Docker Registry Tokens
[a-zA-Z0-9_-]*docker[a-zA-Z0-9_-]*\s*[:=]\s*['"'"'"][a-zA-Z0-9_-]{20,}['"'"'"]

# Slack Tokens
xox[baprs]-[0-9a-zA-Z-]{10,48}

# Generic Passwords
password\s*[:=]\s*['"'"'"][^'"'"'"]{8,}['"'"'"]
passwd\s*[:=]\s*['"'"'"][^'"'"'"]{8,}['"'"'"]
pwd\s*[:=]\s*['"'"'"][^'"'"'"]{8,}['"'"'"]

# Cryptocurrency Addresses
[13][a-km-zA-HJ-NP-Z1-9]{25,34}
bc1[a-z0-9]{39,59}
0x[a-fA-F0-9]{40}

# Credit Card Numbers
4[0-9]{12}(?:[0-9]{3})?
5[1-5][0-9]{14}
3[47][0-9]{13}

# Social Security Numbers
\b\d{3}-\d{2}-\d{4}\b
\b\d{3}\s\d{2}\s\d{4}\b

# Email and Phone Patterns
[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}
\+?[1-9]\d{1,14}

# Azure Tokens
[a-zA-Z0-9_-]*azure[a-zA-Z0-9_-]*\s*[:=]\s*['"'"'"][a-zA-Z0-9_-]{20,}['"'"'"]

# Twilio
SK[a-z0-9]{32}
AC[a-z0-9]{32}

# SendGrid
SG\.[a-zA-Z0-9_-]{22}\.[a-zA-Z0-9_-]{43}

# Stripe
sk_live_[0-9a-zA-Z]{24}
pk_live_[0-9a-zA-Z]{24}

# PayPal
access_token\$production\$[a-z0-9]{16}\$[a-z0-9]{32}

# Square
sq0atp-[0-9A-Za-z_-]{22}
sq0csp-[0-9A-Za-z_-]{43}
EOF
}

# Create whitelist files configuration
create_whitelist_files_config() {
    cat > "$CONFIG_DIR/whitelist-files.conf" << 'EOF'
# Secret WAR File Whitelist
# Add file patterns to ignore (one per line)

# IDE and Editor files
.vscode/
.idea/
*.swp
*.swo
*~

# Build and dependency files
node_modules/
vendor/
target/
build/
dist/
*.class
*.jar
*.war

# Log files
*.log
logs/

# Temporary files
*.tmp
*.temp

# Binary files
*.exe
*.dll
*.so
*.dylib
*.bin
*.dat

# Image files
*.jpg
*.jpeg
*.png
*.gif
*.bmp
*.ico
*.svg

# Archive files
*.zip
*.tar
*.gz
*.rar
*.7z

# Documentation
*.pdf
*.doc
*.docx

# OS generated files
.DS_Store
Thumbs.db
EOF
}

# Create whitelist patterns configuration
create_whitelist_patterns_config() {
    cat > "$CONFIG_DIR/whitelist-patterns.conf" << 'EOF'
# Secret WAR Pattern Whitelist
# Add regex patterns to whitelist (one per line)

# Test files and examples
test.*password.*=.*example
.*example.*key.*=.*dummy
.*sample.*token.*=.*fake
.*mock.*secret.*=.*test

# Documentation patterns
#.*api.*key.*in.*documentation
#.*token.*example.*in.*readme

# Environment template files  
.*\.env\.template
.*\.env\.example
.*\.env\.sample
EOF
}

# Create functions library
create_functions_library() {
    # Extract functions from main script or create them
    local functions_file="$CONFIG_DIR/secret-war-functions.sh"
    
    cat > "$functions_file" << 'FUNCTIONS_EOF'
# Secret WAR Functions Library

# Load patterns from config
load_patterns() {
    local patterns=()
    while IFS= read -r line; do
        if [[ ! "$line" =~ ^[[:space:]]*# ]] && [[ -n "${line// }" ]]; then
            patterns+=("$line")
        fi
    done < "$CONFIG_DIR/patterns.conf"
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
    git diff --cached --name-only --diff-filter=ACM | grep -v -E '\.(gitignore|gitattributes)$|\.git/|\.vscode/|\.idea/' || true
}
FUNCTIONS_EOF
}

# Install global pre-commit hook
install_global_hook() {
    print_step "Installing global pre-commit hook..."
    
    local git_template_dir="$HOME/.git-templates"
    local hooks_dir="$git_template_dir/hooks"
    
    # Create template directory
    mkdir -p "$hooks_dir"
    
    # Set global template directory
    git config --global init.templateDir "$git_template_dir"
    
    # Create pre-commit hook
    create_precommit_hook "$hooks_dir/pre-commit"
    
    print_success "Global hook installed successfully"
    print_info "All new repositories will automatically use Secret WAR"
    
    # Ask if user wants to apply to existing repositories
    echo ""
    echo -ne "${CYAN}Apply to existing repositories? [y/N]: ${NC}"
    read -r apply_existing
    
    if [[ "$apply_existing" =~ ^[Yy]$ ]]; then
        apply_to_existing_repos
    fi
}

# Install local pre-commit hook
install_local_hook() {
    print_step "Installing local pre-commit hook..."
    
    # Check if we're in a git repository
    if ! git rev-parse --git-dir >/dev/null 2>&1; then
        print_error "Not in a git repository!"
        echo "Please run this command from within a git repository."
        exit 1
    fi
    
    local git_dir
    git_dir="$(git rev-parse --git-dir)"
    local hooks_dir="$git_dir/hooks"
    
    # Create hooks directory if it doesn't exist
    mkdir -p "$hooks_dir"
    
    # Create pre-commit hook
    create_precommit_hook "$hooks_dir/pre-commit"
    
    local repo_name
    repo_name=$(basename "$(git rev-parse --show-toplevel)")
    
    print_success "Local hook installed for repository: $repo_name"
}

# Create pre-commit hook file
create_precommit_hook() {
    local hook_file="$1"
    
    # Backup existing hook if it exists
    if [[ -f "$hook_file" ]] && [[ "$FORCE_INSTALL" != true ]]; then
        if ! grep -q "Secret WAR" "$hook_file" 2>/dev/null; then
            print_warning "Existing pre-commit hook found"
            echo -ne "${CYAN}Backup and replace? [y/N]: ${NC}"
            read -r backup_choice
            
            if [[ "$backup_choice" =~ ^[Yy]$ ]]; then
                cp "$hook_file" "$hook_file.backup.$(date +%s)"
                print_info "Existing hook backed up"
            else
                print_error "Installation cancelled"
                exit 1
            fi
        fi
    fi
    
    cat > "$hook_file" << 'HOOK_EOF'
#!/bin/bash

# Secret WAR Pre-commit Hook
# This hook is automatically installed by Secret WAR installer
# "Dread it, Run from it. Destiny Still arrives"

set -euo pipefail

# Configuration
CONFIG_DIR="$HOME/.secret-war"
REPORT_DIR="$CONFIG_DIR/reports"
TEMP_DIR="/tmp/secret-war-$"
MAX_THREADS=8

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m'

# Cleanup function
cleanup() {
    if [[ -d "$TEMP_DIR" ]]; then
        rm -rf "$TEMP_DIR" 2>/dev/null || true
    fi
}
trap cleanup EXIT

# Check if Secret WAR is installed
if [[ ! -f "$CONFIG_DIR/secret-war-functions.sh" ]]; then
    echo -e "${RED}❌ Secret WAR not properly installed!${NC}"
    echo -e "${YELLOW}Please run the installer: curl -sSL https://raw.githubusercontent.com/your-repo/secret-war/main/install.sh | bash${NC}"
    exit 1
fi

# Source the main Secret WAR functions
source "$CONFIG_DIR/secret-war-functions.sh"

# Load patterns from config
load_patterns() {
    local patterns=()
    while IFS= read -r line; do
        if [[ ! "$line" =~ ^[[:space:]]*# ]] && [[ -n "${line// }" ]]; then
            patterns+=("$line")
        fi
    done < "$CONFIG_DIR/patterns.conf"
    printf '%s\n' "${patterns[@]}"
}

# Scan file for patterns
scan_file() {
    local file="$1"
    local output_file="$2"
    local patterns
    readarray -t patterns < <(load_patterns)
    
    # Skip if file is whitelisted
    if is_file_whitelisted "$file"; then
        return 0
    fi
    
    # Skip binary files
    if ! file "$file" 2>/dev/null | grep -q text; then
        return 0
    fi
    
    local found_issues=0
    
    for pattern in "${patterns[@]}"; do
        if [[ -n "$pattern" ]]; then
            local matches
            matches=$(git grep -n -E "$pattern" -- "$file" 2>/dev/null || true)
            
            if [[ -n "$matches" ]]; then
                while IFS= read -r match; do
                    if ! is_match_whitelisted "$match"; then
                        echo "$match" >> "$output_file"
                        found_issues=1
                    fi
                done <<< "$matches"
            fi
        fi
    done
    
    return $found_issues
}

# Process files in parallel
process_files_parallel() {
    local files=("$@")
    local temp_results=()
    local pids=()
    
    mkdir -p "$TEMP_DIR"
    
    local chunk_size=$(( (${#files[@]} + MAX_THREADS - 1) / MAX_THREADS ))
    local chunk_num=0
    
    for ((i=0; i<${#files[@]}; i+=chunk_size)); do
        local chunk=("${files[@]:i:chunk_size}")
        local result_file="$TEMP_DIR/result_$chunk_num"
        temp_results+=("$result_file")
        
        {
            for file in "${chunk[@]}"; do
                if [[ -f "$file" ]]; then
                    scan_file "$file" "$result_file"
                fi
            done
        } &
        
        pids+=($!)
        ((chunk_num++))
    done
    
    for pid in "${pids[@]}"; do
        wait "$pid"
    done
    
    local all_results="$TEMP_DIR/all_results"
    for result_file in "${temp_results[@]}"; do
        if [[ -f "$result_file" ]]; then
            cat "$result_file" >> "$all_results" 2>/dev/null || true
        fi
    done
    
    if [[ -f "$all_results" ]]; then
        cat "$all_results"
    fi
}

# Generate HTML report
generate_html_report() {
    local results="$1"
    local timestamp=$(date '+%Y-%m-%d_%H-%M-%S')
    local report_file="$REPORT_DIR/secret-war-report-$timestamp.html"
    
    mkdir -p "$REPORT_DIR"
    
    cat > "$report_file" << 'REPORT_EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Secret WAR Security Report</title>
    <style>
        body {
            font-family: 'Courier New', monospace;
            background: linear-gradient(135deg, #0c0c0c 0%, #1a1a1a 100%);
            color: #00ff00;
            margin: 0;
            padding: 20px;
            min-height: 100vh;
        }
        .header {
            text-align: center;
            margin-bottom: 30px;
            padding: 20px;
            border: 2px solid #ff0000;
            border-radius: 10px;
            background: rgba(255, 0, 0, 0.1);
        }
        .title {
            font-size: 2.5em;
            color: #ff0000;
            text-shadow: 0 0 10px #ff0000;
            margin-bottom: 10px;
        }
        .stats {
            display: flex;
            justify-content: space-around;
            margin: 20px 0;
            padding: 15px;
            background: rgba(0, 255, 0, 0.1);
            border: 1px solid #00ff00;
            border-radius: 5px;
        }
        .warning {
            color: #ff0000;
            font-weight: bold;
            font-size: 1.5em;
            text-align: center;
            margin: 20px 0;
            animation: blink 1s infinite;
        }
        @keyframes blink {
            0%, 50% { opacity: 1; }
            51%, 100% { opacity: 0.3; }
        }
        .success {
            text-align: center;
            margin: 50px 0;
            font-size: 2em;
            color: #00ff00;
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="title">SECRET WAR</div>
        <div style="color: #ff0000;">Dread it, Run from it. Destiny Still arrives</div>
    </div>
REPORT_EOF

    if [[ -n "$results" ]]; then
        local total_issues=$(echo "$results" | wc -l)
        cat >> "$report_file" << ISSUES_EOF
    <div class="warning">⚠️ SECURITY VULNERABILITIES DETECTED ⚠️</div>
    <div class="stats">
        <div>Issues Found: $total_issues</div>
        <div>Scan Time: $(date '+%Y-%m-%d %H:%M:%S')</div>
    </div>
    <pre>$results</pre>
ISSUES_EOF
    else
        cat >> "$report_file" << SUCCESS_EOF
    <div class="success">
        ✅ We Won Secret War!!!!!!!! Love you 3000
        <br><small>No security vulnerabilities detected</small>
    </div>
SUCCESS_EOF
    fi
    
    echo "</body></html>" >> "$report_file"
    echo "$report_file"
}

# Open report in browser
open_report() {
    local report_file="$1"
    
    if command -v xdg-open >/dev/null 2>&1; then
        xdg-open "$report_file" >/dev/null 2>&1 &
    elif command -v open >/dev/null 2>&1; then
        open "$report_file" >/dev/null 2>&1 &
    elif command -v start >/dev/null 2>&1; then
        start "$report_file" >/dev/null 2>&1 &
    fi
}

# Show success message
show_success_message() {
    local message="We Won Secret War!!!!!!!! Love you 3000"
    
    if [[ -n "${DISPLAY:-}" ]] || [[ -n "${WAYLAND_DISPLAY:-}" ]]; then
        if command -v notify-send >/dev/null 2>&1; then
            notify-send "Secret WAR" "$message" --icon=dialog-information 2>/dev/null || true
        elif command -v osascript >/dev/null 2>&1; then
            osascript -e "display notification \"$message\" with title \"Secret WAR\"" 2>/dev/null || true
        fi
    fi
    
    echo -e "${GREEN}✅ $message${NC}"
}

# Main execution
main() {
    echo -e "${YELLOW}🛡️  Secret WAR Security Scan Starting...${NC}"
    
    local staged_files
    readarray -t staged_files < <(get_staged_files)
    
    if [[ ${#staged_files[@]} -eq 0 ]]; then
        echo -e "${YELLOW}No files to scan${NC}"
        exit 0
    fi
    
    echo -e "${BLUE}Scanning ${#staged_files[@]} files with $MAX_THREADS threads...${NC}"
    
    local results
    results=$(process_files_parallel "${staged_files[@]}")
    
    local report_file
    report_file=$(generate_html_report "$results")
    
    if [[ -n "$results" ]]; then
        echo -e "${RED}"
        echo "╔════════════════════════════════════════════════════════════════╗"
        echo "║                    SECURITY ALERT                             ║"
        echo "║            Dread it, Run from it. Destiny Still arrives       ║"
        echo "╚════════════════════════════════════════════════════════════════╝"
        echo -e "${NC}"
        
        echo -e "${RED}❌ Security vulnerabilities detected!${NC}"
        echo -e "${YELLOW}📊 Report: $report_file${NC}"
        
        open_report "$report_file"
        
        echo -e "${RED}Commit blocked for security reasons.${NC}"
        exit 1
    else
        show_success_message
        open_report "$report_file"
        exit 0
    fi
}

main "$@"
HOOK_EOF

    chmod +x "$hook_file"
}

# Apply to existing repositories
apply_to_existing_repos() {
    print_step "Applying to existing repositories..."
    
    local repos_found=0
    local repos_updated=0
    
    # Find git repositories in common locations
    local search_paths=("$HOME/Projects" "$HOME/Code" "$HOME/Development" "$HOME/src" "$HOME/git" "$HOME")
    
    for search_path in "${search_paths[@]}"; do
        if [[ -d "$search_path" ]]; then
            while IFS= read -r -d '' repo_path; do
                if [[ -d "$repo_path/.git" ]]; then
                    ((repos_found++))
                    
                    local repo_name
                    repo_name=$(basename "$repo_path")
                    
                    if [[ "$VERBOSE" == true ]]; then
                        print_info "Found repository: $repo_name"
                    fi
                    
                    # Apply template to existing repo
                    (
                        cd "$repo_path"
                        git init >/dev/null 2>&1 || true
                        ((repos_updated++))
                    )
                fi
            done < <(find "$search_path" -maxdepth 3 -type d -name ".git" -print0 2>/dev/null)
        fi
    done
    
    if [[ $repos_found -gt 0 ]]; then
        print_success "Applied to $repos_updated of $repos_found repositories found"
    else
        print_info "No existing repositories found in common locations"
    fi
}

# Advanced installation with custom options
install_advanced() {
    echo ""
    echo -e "${BOLD}${CYAN}Advanced Installation Configuration${NC}"
    echo ""
    
    # Choose installation type
    echo -e "${YELLOW}1. Installation Type:${NC}"
    echo "1) Global (recommended)"
    echo "2) Local"
    echo -ne "${CYAN}Choose [1-2]: ${NC}"
    read -r install_choice
    
    case $install_choice in
        1) local_install_type="global" ;;
        2) local_install_type="local" ;;
        *) local_install_type="global" ;;
    esac
    
    # Thread configuration
    echo ""
    echo -e "${YELLOW}2. Thread Configuration:${NC}"
    echo -ne "${CYAN}Number of threads [1-16, default 8]: ${NC}"
    read -r thread_count
    
    if [[ ! "$thread_count" =~ ^[0-9]+$ ]] || [[ $thread_count -lt 1 ]] || [[ $thread_count -gt 16 ]]; then
        thread_count=8
    fi
    
    # Custom patterns
    echo ""
    echo -e "${YELLOW}3. Pattern Configuration:${NC}"
    echo -ne "${CYAN}Add custom patterns file? [y/N]: ${NC}"
    read -r custom_patterns
    
    # Report configuration
    echo ""
    echo -e "${YELLOW}4. Report Configuration:${NC}"
    echo -ne "${CYAN}Custom report directory [default: ~/.secret-war/reports]: ${NC}"
    read -r report_dir
    
    if [[ -z "$report_dir" ]]; then
        report_dir="$CONFIG_DIR/reports"
    fi
    
    # Auto-open reports
    echo ""
    echo -ne "${CYAN}Auto-open reports in browser? [Y/n]: ${NC}"
    read -r auto_open
    
    # Summary
    echo ""
    echo -e "${BOLD}${CYAN}Configuration Summary:${NC}"
    echo "Installation Type: $local_install_type"
    echo "Thread Count: $thread_count"
    echo "Custom Patterns: ${custom_patterns:-N}"
    echo "Report Directory: $report_dir"
    echo "Auto-open Reports: ${auto_open:-Y}"
    echo ""
    
    echo -ne "${CYAN}Proceed with installation? [Y/n]: ${NC}"
    read -r proceed
    
    if [[ "$proceed" =~ ^[Nn]$ ]]; then
        print_info "Installation cancelled"
        exit 0
    fi
    
    # Apply configuration
    export MAX_THREADS="$thread_count"
    mkdir -p "$report_dir"
    
    # Perform installation
    if [[ "$local_install_type" == "global" ]]; then
        install_global_hook
    else
        install_local_hook
    fi
    
    # Handle custom patterns
    if [[ "$custom_patterns" =~ ^[Yy]$ ]]; then
        echo ""
        print_info "Custom patterns file created at: $CONFIG_DIR/patterns.conf"
        print_info "Edit this file to add your custom detection patterns"
    fi
}

# Update existing installation
update_installation() {
    print_step "Updating Secret WAR installation..."
    
    if [[ ! -d "$CONFIG_DIR" ]]; then
        print_error "Secret WAR not installed. Use --global or --local to install."
        exit 1
    fi
    
    # Backup existing configuration
    local backup_dir="$CONFIG_DIR/backup-$(date +%s)"
    mkdir -p "$backup_dir"
    
    if [[ -f "$CONFIG_DIR/patterns.conf" ]]; then
        cp "$CONFIG_DIR/patterns.conf" "$backup_dir/"
    fi
    if [[ -f "$CONFIG_DIR/whitelist-files.conf" ]]; then
        cp "$CONFIG_DIR/whitelist-files.conf" "$backup_dir/"
    fi
    if [[ -f "$CONFIG_DIR/whitelist-patterns.conf" ]]; then
        cp "$CONFIG_DIR/whitelist-patterns.conf" "$backup_dir/"
    fi
    
    print_info "Configuration backed up to: $backup_dir"
    
    # Update configuration
    FORCE_INSTALL=true
    setup_config
    
    # Update hooks
    if git config --global --get init.templateDir >/dev/null 2>&1; then
        install_global_hook
    fi
    
    print_success "Secret WAR updated successfully"
}

# Uninstall Secret WAR
uninstall() {
    echo ""
    print_warning "This will remove Secret WAR from your system"
    echo -ne "${CYAN}Are you sure? [y/N]: ${NC}"
    read -r confirm
    
    if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
        print_info "Uninstall cancelled"
        exit 0
    fi
    
    print_step "Uninstalling Secret WAR..."
    
    # Remove global template
    if git config --global --get init.templateDir >/dev/null 2>&1; then
        local template_dir
        template_dir=$(git config --global --get init.templateDir)
        if [[ "$template_dir" == "$HOME/.git-templates" ]]; then
            git config --global --unset init.templateDir
            rm -rf "$HOME/.git-templates"
            print_info "Global template removed"
        fi
    fi
    
    # Remove configuration
    if [[ -d "$CONFIG_DIR" ]]; then
        rm -rf "$CONFIG_DIR"
        print_info "Configuration directory removed"
    fi
    
    print_success "Secret WAR uninstalled successfully"
    print_info "Local repository hooks need to be removed manually if needed"
}

# Installation summary and next steps
show_installation_summary() {
    echo ""
    echo -e "${BOLD}${GREEN}🎉 Secret WAR Installation Complete!${NC}"
    echo ""
    echo -e "${CYAN}What's Next:${NC}"
    
    case $INSTALL_TYPE in
        "global")
            echo "✅ Global hooks installed - all repositories are now protected"
            echo "✅ New repositories will automatically use Secret WAR"
            ;;
        "local")
            echo "✅ Local hook installed for current repository"
            echo "💡 Run with --global to protect all repositories"
            ;;
        "advanced")
            echo "✅ Advanced configuration applied"
            echo "⚙️  Configuration files available in $CONFIG_DIR"
            ;;
    esac
    
    echo ""
    echo -e "${YELLOW}Configuration Files:${NC}"
    echo "📁 Config Directory: $CONFIG_DIR"
    echo "🎯 Patterns: $CONFIG_DIR/patterns.conf"
    echo "📋 File Whitelist: $CONFIG_DIR/whitelist-files.conf"
    echo "🔍 Pattern Whitelist: $CONFIG_DIR/whitelist-patterns.conf"
    echo "📊 Reports: $CONFIG_DIR/reports/"
    
    echo ""
    echo -e "${YELLOW}Testing Your Installation:${NC}"
    echo "1. Create a test file with a fake API key:"
    echo "   echo 'api_key=\"sk-1234567890abcdef\"' > test-secret.txt"
    echo "2. Try to commit it:"
    echo "   git add test-secret.txt && git commit -m 'test'"
    echo "3. Secret WAR should block the commit and show a report"
    
    echo ""
    echo -e "${YELLOW}Need Help?${NC}"
    echo "🆘 Documentation: README.md"
    echo "⚙️  Edit patterns: vim $CONFIG_DIR/patterns.conf"
    echo "🔧 Troubleshooting: $CONFIG_DIR/secret-war.sh --help"
    
    echo ""
    echo -e "${GREEN}Happy secure coding! 🛡️${NC}"
}

# Main installation flow
main() {
    show_banner
    
    # Parse command line arguments
    parse_arguments "$@"
    
    # Check system requirements
    check_requirements
    
    # If no installation type specified, show menu
    if [[ -z "$INSTALL_TYPE" ]]; then
        show_menu
        get_user_choice
    fi
    
    # Setup configuration
    setup_config
    
    # Execute installation based on type
    case $INSTALL_TYPE in
        "global")
            install_global_hook
            ;;
        "local")
            install_local_hook
            ;;
        "advanced")
            install_advanced
            ;;
        "update")
            update_installation
            ;;
        "uninstall")
            uninstall
            exit 0
            ;;
        *)
            print_error "Invalid installation type: $INSTALL_TYPE"
            exit 1
            ;;
    esac
    
    # Show installation summary
    show_installation_summary
}

# Handle script interruption
trap 'echo -e "\n${YELLOW}Installation interrupted by user${NC}"; exit 130' INT TERM

# Run main function with all arguments
main "$@"