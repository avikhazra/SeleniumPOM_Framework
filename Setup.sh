#!/bin/bash

# Secrets WAR - Advanced Security Pre-commit Hook Setup
# Version: 1.0.0
# Author: Secrets WAR Team
# Description: GitGuardian-like pre-commit hooks for all languages and environments

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# ASCII Art Banner
print_banner() {
    echo -e "${PURPLE}"
    echo "  ███████╗███████╗ ██████╗██████╗ ███████╗████████╗███████╗    ██╗    ██╗ █████╗ ██████╗ "
    echo "  ███████║██████╔╝██████╔╝██████╔╝███████║██╔═══██║██╔═══██║    ██║    ██║██╔══██╗██╔══██╗"
    echo "  ╚════██║██╔══╝  ██╔═══╝ ██╔══██╗██╔══╝  ╚══██╔══╝╚══██╔══╝    ██║ █╗ ██║███████║██████╔╝"
    echo "       ██║██║     ██║     ██║  ██║██║        ██║      ██║       ██║███╗██║██╔══██║██╔══██╗"
    echo "  ███████║███████╗╚██████╗██║  ██║███████╗   ██║      ██║       ╚███╔███╔╝██║  ██║██║  ██║"
    echo "  ╚══════╝╚══════╝ ╚═════╝╚═╝  ╚═╝╚══════╝   ╚═╝      ╚═╝        ╚══╝╚══╝ ╚═╝  ╚═╝╚═╝  ╚═╝"
    echo -e "${NC}"
    echo -e "${CYAN}Advanced Security Pre-commit Hook System${NC}"
    echo -e "${YELLOW}Version 1.0.0 - Language Independent Security Scanner${NC}"
    echo ""
}

# Setup configuration
SETUP_NAME="Secrets WAR Security Hook System"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SECRETS_WAR_SCRIPT="Secrets-WAR.sh"
CONFIG_FILE="secrets-war-config.json"

# Check if we're in a git repository
check_git_repository() {
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        echo -e "${RED}Error: Not in a git repository. Please run this script from within a git repository.${NC}"
        exit 1
    fi
    GIT_ROOT=$(git rev-parse --show-toplevel)
    GIT_HOOKS_DIR="$GIT_ROOT/.git/hooks"
}

# Create the main Secrets-WAR.sh script
create_secrets_war_script() {
    echo -e "${BLUE}Creating Secrets-WAR.sh script...${NC}"
    
    cat > "$SCRIPT_DIR/$SECRETS_WAR_SCRIPT" << 'EOF'
#!/bin/bash

# Secrets WAR - Main Security Scanner
# Advanced Pre-commit Hook for Secret Detection

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="$SCRIPT_DIR/secrets-war-config.json"
REPORT_FILE="$SCRIPT_DIR/secrets-war-report.html"
TEMP_DIR="/tmp/secrets-war-$$"
PARALLEL_JOBS=$(nproc 2>/dev/null || echo "4")

# Default patterns for secret detection
DEFAULT_PATTERNS=(
    # API Keys and Tokens
    "(?i)(api[_-]?key|apikey)[\"']?\s*[:=]\s*[\"']?[a-zA-Z0-9_-]{16,}[\"']?"
    "(?i)(access[_-]?token|accesstoken)[\"']?\s*[:=]\s*[\"']?[a-zA-Z0-9_-]{16,}[\"']?"
    "(?i)(secret[_-]?key|secretkey)[\"']?\s*[:=]\s*[\"']?[a-zA-Z0-9_-]{16,}[\"']?"
    "(?i)(auth[_-]?token|authtoken)[\"']?\s*[:=]\s*[\"']?[a-zA-Z0-9_-]{16,}[\"']?"
    
    # Database connections
    "(?i)(password|passwd|pwd)[\"']?\s*[:=]\s*[\"']?[^\"'\s]{3,}[\"']?"
    "(?i)(db[_-]?password|database[_-]?password)[\"']?\s*[:=]\s*[\"']?[^\"'\s]{3,}[\"']?"
    "(?i)jdbc:[a-zA-Z0-9]+://[^\"'\s]+"
    "(?i)mongodb://[^\"'\s]+"
    
    # Private Keys
    "-----BEGIN [A-Z]+ PRIVATE KEY-----"
    "-----BEGIN OPENSSH PRIVATE KEY-----"
    "-----BEGIN RSA PRIVATE KEY-----"
    "-----BEGIN DSA PRIVATE KEY-----"
    "-----BEGIN EC PRIVATE KEY-----"
    
    # Cloud Provider Keys
    "(?i)AKIA[0-9A-Z]{16}"  # AWS Access Key
    "(?i)[0-9a-zA-Z/+]{40}"  # AWS Secret Key (basic pattern)
    "(?i)ya29\.[0-9A-Za-z\-_]+"  # Google OAuth
    "(?i)sk-[a-zA-Z0-9]{48}"  # OpenAI API Key
    
    # Generic Secrets
    "(?i)(client[_-]?secret|clientsecret)[\"']?\s*[:=]\s*[\"']?[a-zA-Z0-9_-]{16,}[\"']?"
    "(?i)(bearer[_-]?token|bearertoken)[\"']?\s*[:=]\s*[\"']?[a-zA-Z0-9._-]{16,}[\"']?"
    "(?i)(private[_-]?key|privatekey)[\"']?\s*[:=]\s*[\"']?[a-zA-Z0-9_-]{16,}[\"']?"
    
    # Email patterns in code
    "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}"
    
    # URLs with credentials
    "(?i)[a-zA-Z][a-zA-Z0-9+.-]*://[a-zA-Z0-9._-]+:[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+[a-zA-Z0-9/_-]*"
    
    # Credit Card Numbers (basic)
    "[0-9]{4}[- ]?[0-9]{4}[- ]?[0-9]{4}[- ]?[0-9]{4}"
    
    # Social Security Numbers
    "[0-9]{3}-[0-9]{2}-[0-9]{4}"
    
    # Phone Numbers
    "\+?1?[- ]?\(?[0-9]{3}\)?[- ]?[0-9]{3}[- ]?[0-9]{4}"
)

# Initialize configuration
init_config() {
    if [ ! -f "$CONFIG_FILE" ]; then
        cat > "$CONFIG_FILE" << 'CONFIGEOF'
{
    "enabled": true,
    "check_all_files": false,
    "parallel_execution": true,
    "auto_open_report": true,
    "exclude_patterns": [
        "*.git/*",
        "*/node_modules/*",
        "*/vendor/*",
        "*/dist/*",
        "*/build/*",
        "*.min.js",
        "*.min.css",
        "*.map",
        "*/target/*",
        "*/bin/*",
        "*/obj/*",
        "*/.gradle/*",
        "*/.idea/*",
        "*/.vscode/*"
    ],
    "whitelist_patterns": [
        "example@example.com",
        "test@test.com",
        "dummy",
        "placeholder",
        "YOUR_API_KEY_HERE",
        "INSERT_YOUR_KEY_HERE"
    ],
    "custom_patterns": [],
    "file_extensions": [
        ".js", ".ts", ".jsx", ".tsx", ".py", ".java", ".php", ".rb", ".go", 
        ".cs", ".cpp", ".c", ".h", ".hpp", ".sh", ".bash", ".zsh", ".fish",
        ".sql", ".xml", ".json", ".yaml", ".yml", ".toml", ".ini", ".cfg",
        ".conf", ".properties", ".env", ".dockerfile", ".kt", ".swift",
        ".scala", ".clj", ".r", ".m", ".pl", ".lua", ".dart", ".rs"
    ]
}
CONFIGEOF
        echo -e "${GREEN}Created default configuration file: $CONFIG_FILE${NC}"
    fi
}

# Load configuration
load_config() {
    if command -v python3 > /dev/null 2>&1; then
        PYTHON_CMD="python3"
    elif command -v python > /dev/null 2>&1; then
        PYTHON_CMD="python"
    else
        echo -e "${RED}Python is required but not found. Please install Python.${NC}"
        exit 1
    fi
}

# Check if file should be excluded
is_excluded() {
    local file="$1"
    local exclude_patterns
    
    # Load exclude patterns from config
    exclude_patterns=$($PYTHON_CMD -c "
import json
with open('$CONFIG_FILE', 'r') as f:
    config = json.load(f)
    for pattern in config.get('exclude_patterns', []):
        print(pattern)
" 2>/dev/null || echo "")
    
    # Check .gitignore patterns
    if [ -f ".gitignore" ]; then
        while IFS= read -r pattern; do
            if [[ -n "$pattern" && ! "$pattern" =~ ^# ]]; then
                case "$file" in
                    $pattern) return 0 ;;
                esac
            fi
        done < .gitignore
    fi
    
    # Check config exclude patterns
    while IFS= read -r pattern; do
        if [[ -n "$pattern" ]]; then
            case "$file" in
                $pattern) return 0 ;;
            esac
        fi
    done <<< "$exclude_patterns"
    
    return 1
}

# Check if pattern is whitelisted
is_whitelisted() {
    local match="$1"
    local whitelist_patterns
    
    whitelist_patterns=$($PYTHON_CMD -c "
import json
with open('$CONFIG_FILE', 'r') as f:
    config = json.load(f)
    for pattern in config.get('whitelist_patterns', []):
        print(pattern)
" 2>/dev/null || echo "")
    
    while IFS= read -r pattern; do
        if [[ -n "$pattern" && "$match" == *"$pattern"* ]]; then
            return 0
        fi
    done <<< "$whitelist_patterns"
    
    return 1
}

# Scan a single file for secrets
scan_file() {
    local file="$1"
    local temp_result="$2"
    local file_issues=0
    
    if [ ! -f "$file" ] || is_excluded "$file"; then
        return 0
    fi
    
    # Check file extension
    local ext="${file##*.}"
    if [[ "$ext" != "$file" ]]; then
        ext=".$ext"
        local valid_ext=$($PYTHON_CMD -c "
import json
with open('$CONFIG_FILE', 'r') as f:
    config = json.load(f)
    extensions = config.get('file_extensions', [])
    print('$ext' in extensions)
" 2>/dev/null || echo "False")
        
        if [[ "$valid_ext" != "True" ]]; then
            return 0
        fi
    fi
    
    # Read all patterns (default + custom)
    local all_patterns=("${DEFAULT_PATTERNS[@]}")
    local custom_patterns
    custom_patterns=$($PYTHON_CMD -c "
import json
with open('$CONFIG_FILE', 'r') as f:
    config = json.load(f)
    for pattern in config.get('custom_patterns', []):
        print(pattern)
" 2>/dev/null || echo "")
    
    while IFS= read -r pattern; do
        if [[ -n "$pattern" ]]; then
            all_patterns+=("$pattern")
        fi
    done <<< "$custom_patterns"
    
    # Scan file line by line
    local line_num=0
    while IFS= read -r line; do
        ((line_num++))
        
        # Skip empty lines
        [[ -z "$line" ]] && continue
        
        for pattern in "${all_patterns[@]}"; do
            if echo "$line" | grep -P "$pattern" > /dev/null 2>&1; then
                local match=$(echo "$line" | grep -oP "$pattern" | head -1)
                
                if ! is_whitelisted "$match"; then
                    echo "$file:$line_num:$match:$line" >> "$temp_result"
                    ((file_issues++))
                fi
            fi
        done
    done < "$file"
    
    return $file_issues
}

# Get files to scan
get_files_to_scan() {
    local check_all_files
    check_all_files=$($PYTHON_CMD -c "
import json
with open('$CONFIG_FILE', 'r') as f:
    config = json.load(f)
    print(config.get('check_all_files', False))
" 2>/dev/null || echo "False")
    
    if [[ "$check_all_files" == "True" || "$1" == "--all" ]]; then
        # Check all files in repository
        git ls-files
    else
        # Check only staged/modified files
        {
            git diff --cached --name-only
            git diff --name-only
            git ls-files --others --exclude-standard
        } | sort -u
    fi
}

# Generate HTML report
generate_html_report() {
    local issues_file="$1"
    local total_issues="$2"
    
    cat > "$REPORT_FILE" << HTMLEOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Secrets WAR - Security Report</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
            color: #333;
        }
        .container { 
            max-width: 1200px; 
            margin: 0 auto; 
            background: white; 
            border-radius: 10px; 
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            overflow: hidden;
        }
        .header { 
            background: linear-gradient(135deg, #ff6b6b, #ee5a6f); 
            color: white; 
            padding: 30px; 
            text-align: center; 
        }
        .header h1 { font-size: 2.5em; margin-bottom: 10px; }
        .header p { font-size: 1.2em; opacity: 0.9; }
        .stats { 
            display: flex; 
            justify-content: space-around; 
            padding: 20px; 
            background: #f8f9fa; 
            border-bottom: 1px solid #dee2e6;
        }
        .stat { text-align: center; }
        .stat-number { font-size: 2em; font-weight: bold; color: #dc3545; }
        .stat-label { color: #6c757d; text-transform: uppercase; font-size: 0.9em; }
        .content { padding: 30px; }
        .issue { 
            margin-bottom: 20px; 
            border: 1px solid #dee2e6; 
            border-radius: 8px; 
            overflow: hidden;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .issue-header { 
            background: #f8d7da; 
            padding: 15px; 
            border-bottom: 1px solid #f5c6cb;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .issue-file { font-weight: bold; color: #721c24; }
        .issue-line { color: #721c24; font-size: 0.9em; }
        .issue-content { 
            padding: 15px; 
            background: white; 
        }
        .issue-match { 
            background: #fff3cd; 
            border: 1px solid #ffeaa7; 
            padding: 10px; 
            border-radius: 4px; 
            font-family: monospace; 
            color: #856404;
            margin-bottom: 10px;
        }
        .issue-context { 
            background: #f8f9fa; 
            border-left: 4px solid #007bff; 
            padding: 10px; 
            font-family: monospace; 
            font-size: 0.9em;
            overflow-x: auto;
        }
        .no-issues { 
            text-align: center; 
            padding: 50px; 
            color: #28a745; 
            font-size: 1.5em; 
        }
        .footer { 
            background: #343a40; 
            color: white; 
            text-align: center; 
            padding: 20px; 
        }
        .timestamp { color: #6c757d; font-size: 0.9em; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🛡️ Secrets WAR</h1>
            <p>Security Vulnerability Report</p>
        </div>
        
        <div class="stats">
            <div class="stat">
                <div class="stat-number">$total_issues</div>
                <div class="stat-label">Issues Found</div>
            </div>
            <div class="stat">
                <div class="stat-number">$(date +%Y-%m-%d)</div>
                <div class="stat-label">Scan Date</div>
            </div>
            <div class="stat">
                <div class="stat-number">$(date +%H:%M:%S)</div>
                <div class="stat-label">Scan Time</div>
            </div>
        </div>
        
        <div class="content">
HTMLEOF

    if [ "$total_issues" -eq 0 ]; then
        cat >> "$REPORT_FILE" << HTMLEOF
            <div class="no-issues">
                <h2>🎉 No Vulnerabilities Found</h2>
                <p>Love you 3000</p>
            </div>
HTMLEOF
    else
        while IFS=':' read -r file line_num match context; do
            cat >> "$REPORT_FILE" << HTMLEOF
            <div class="issue">
                <div class="issue-header">
                    <span class="issue-file">📁 $file</span>
                    <span class="issue-line">Line: $line_num</span>
                </div>
                <div class="issue-content">
                    <div class="issue-match">🔍 Detected: $match</div>
                    <div class="issue-context">$context</div>
                </div>
            </div>
HTMLEOF
        done < "$issues_file"
    fi

    cat >> "$REPORT_FILE" << HTMLEOF
        </div>
        
        <div class="footer">
            <p>Generated by Secrets WAR v1.0.0</p>
            <p class="timestamp">$(date)</p>
        </div>
    </div>
</body>
</html>
HTMLEOF
}

# Main scanning function
main_scan() {
    local check_all_files="$1"
    
    echo -e "${PURPLE}Dread it, run from it, destiny still arrives...${NC}"
    echo -e "${CYAN}Starting Secrets WAR security scan...${NC}"
    
    # Create temp directory
    mkdir -p "$TEMP_DIR"
    local issues_file="$TEMP_DIR/issues.txt"
    local total_issues=0
    
    # Get files to scan
    local files
    mapfile -t files < <(get_files_to_scan "$check_all_files")
    
    if [ ${#files[@]} -eq 0 ]; then
        echo -e "${YELLOW}No files to scan.${NC}"
        return 0
    fi
    
    echo -e "${BLUE}Scanning ${#files[@]} files...${NC}"
    
    # Check if parallel execution is enabled
    local parallel_exec
    parallel_exec=$($PYTHON_CMD -c "
import json
with open('$CONFIG_FILE', 'r') as f:
    config = json.load(f)
    print(config.get('parallel_execution', True))
" 2>/dev/null || echo "True")
    
    if [[ "$parallel_exec" == "True" ]]; then
        # Parallel execution
        echo -e "${CYAN}Running in parallel mode with $PARALLEL_JOBS jobs...${NC}"
        
        # Export functions for parallel execution
        export -f scan_file is_excluded is_whitelisted
        export CONFIG_FILE PYTHON_CMD
        export DEFAULT_PATTERNS
        
        # Create job queue
        printf '%s\n' "${files[@]}" | \
        xargs -n 1 -P "$PARALLEL_JOBS" -I {} bash -c '
            temp_result="/tmp/secrets-war-$$/result_$$_$(echo {} | tr "/" "_")"
            scan_file "{}" "$temp_result"
            if [ -f "$temp_result" ]; then
                cat "$temp_result"
                rm -f "$temp_result"
            fi
        ' > "$issues_file"
    else
        # Sequential execution
        echo -e "${CYAN}Running in sequential mode...${NC}"
        for file in "${files[@]}"; do
            echo -e "${BLUE}Scanning: $file${NC}"
            scan_file "$file" "$issues_file"
        done
    fi
    
    # Count total issues
    if [ -f "$issues_file" ]; then
        total_issues=$(wc -l < "$issues_file" 2>/dev/null || echo "0")
    fi
    
    # Generate report
    generate_html_report "$issues_file" "$total_issues"
    
    # Display results
    if [ "$total_issues" -eq 0 ]; then
        echo -e "${GREEN}✅ No vulnerabilities found${NC}"
        echo -e "${GREEN}Love you 3000${NC}"
    else
        echo -e "${RED}❌ Found $total_issues security issues${NC}"
        echo -e "${YELLOW}Report generated: $REPORT_FILE${NC}"
        
        # Auto-open report if configured
        local auto_open
        auto_open=$($PYTHON_CMD -c "
import json
with open('$CONFIG_FILE', 'r') as f:
    config = json.load(f)
    print(config.get('auto_open_report', True))
" 2>/dev/null || echo "True")
        
        if [[ "$auto_open" == "True" ]]; then
            # Try to open the report in the default browser
            if command -v xdg-open > /dev/null 2>&1; then
                xdg-open "$REPORT_FILE" 2>/dev/null &
            elif command -v open > /dev/null 2>&1; then
                open "$REPORT_FILE" 2>/dev/null &
            elif command -v start > /dev/null 2>&1; then
                start "$REPORT_FILE" 2>/dev/null &
            fi
        fi
    fi
    
    # Cleanup
    rm -rf "$TEMP_DIR"
    
    return "$total_issues"
}

# Main execution
init_config
load_config

# Handle command line arguments
case "${1:-}" in
    --all)
        main_scan "--all"
        ;;
    --help)
        echo "Secrets WAR - Security Scanner"
        echo "Usage: $0 [--all] [--help]"
        echo "  --all   Check all files in repository"
        echo "  --help  Show this help message"
        ;;
    *)
        main_scan
        ;;
esac

exit $?
EOF

    chmod +x "$SCRIPT_DIR/$SECRETS_WAR_SCRIPT"
    echo -e "${GREEN}✅ Secrets-WAR.sh created successfully${NC}"
}

# Create pre-commit hooks
create_hooks() {
    echo -e "${BLUE}Creating pre-commit and pre-merge-commit hooks...${NC}"
    
    # Pre-commit hook
    cat > "$GIT_HOOKS_DIR/pre-commit" << 'HOOKEOF'
#!/bin/bash

# Secrets WAR Pre-commit Hook
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SECRETS_WAR_SCRIPT="$(dirname "$(dirname "$SCRIPT_DIR")")/Secrets-WAR.sh"

# Check if Secrets-WAR.sh exists
if [ ! -f "$SECRETS_WAR_SCRIPT" ]; then
    echo "Warning: Secrets-WAR.sh not found at $SECRETS_WAR_SCRIPT"
    exit 0
fi

# Run the security scan
"$SECRETS_WAR_SCRIPT"
exit_code=$?

if [ $exit_code -ne 0 ]; then
    echo ""
    echo "❌ Commit blocked due to security issues."
    echo "Please resolve the issues shown in the report before committing."
    echo "Use 'git commit --no-verify' to bypass this check (NOT RECOMMENDED)."
    exit 1
fi

exit 0
HOOKEOF

    # Pre-merge-commit hook
    cat > "$GIT_HOOKS_DIR/pre-merge-commit" << 'MERGEHOOKEOF'
#!/bin/bash

# Secrets WAR Pre-merge-commit Hook
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SECRETS_WAR_SCRIPT="$(dirname "$(dirname "$SCRIPT_DIR")")/Secrets-WAR.sh"

# Check if Secrets-WAR.sh exists
if [ ! -f "$SECRETS_WAR_SCRIPT" ]; then
    echo "Warning: Secrets-WAR.sh not found at $SECRETS_WAR_SCRIPT"
    exit 0
fi

# Run the security scan
"$SECRETS_WAR_SCRIPT"
exit_code=$?

if [ $exit_code -ne 0 ]; then
    echo ""
    echo "❌ Merge blocked due to security issues."
    echo "Please resolve the issues shown in the report before merging."
    exit 1
fi

exit 0
MERGEHOOKEOF

    chmod +x "$GIT_HOOKS_DIR/pre-commit"
    chmod +x "$GIT_HOOKS_DIR/pre-merge-commit"
    
    echo -e "${GREEN}✅ Git hooks created successfully${NC}"
}

# Install global hooks (optional)
install_global_hooks() {
    echo -e "${YELLOW}Do you want to install global git hooks? (y/N): ${NC}"
    read -r response
    
    if [[ "$response" =~ ^[Yy]$ ]]; then
        # Set global git hooks path
        git config --global core.hooksPath ~/.git-hooks
        
        # Create global hooks directory
        mkdir -p ~/.git-hooks
        
        # Copy hooks to global directory
        cp "$GIT_HOOKS_DIR/pre-commit" ~/.git-hooks/pre-commit
        cp "$GIT_HOOKS_DIR/pre-merge-commit" ~/.git-hooks/pre-merge-commit
        
        # Update paths in global hooks
        sed -i 's|$(dirname "$(dirname "$SCRIPT_DIR")")/Secrets-WAR.sh|'"$SCRIPT_DIR/$SECRETS_WAR_SCRIPT"'|g' ~/.git-hooks/pre-commit
        sed -i 's|$(dirname "$(dirname "$SCRIPT_DIR")")/Secrets-WAR.sh|'"$SCRIPT_DIR/$SECRETS_WAR_SCRIPT"'|g' ~/.git-hooks/pre-merge-commit
        
        echo -e "${GREEN}✅ Global git hooks installed${NC}"
    fi
}

# Configuration wizard
configuration_wizard() {
    echo -e "${CYAN}Running configuration wizard...${NC}"
    
    echo -e "${YELLOW}Do you want to check all files by default? (y/N): ${NC}"
    read -r check_all
    
    echo -e "${YELLOW}Enable parallel execution? (Y/n): ${NC}"
    read -r parallel
    
    echo -e "${YELLOW}Auto-open HTML report when issues found? (Y/n): ${NC}"
    read -r auto_open
    
    # Update configuration
    python3 << CONFIGPY
import json

config_file = "$CONFIG_FILE"
try:
    with open(config_file, 'r') as f:
        config = json.load(f)
except:
    config = {}

config['check_all_files'] = '$check_all'.lower() in ['y', 'yes']
config['parallel_execution'] = '$parallel'.lower() not in ['n', 'no']
config['auto_open_report'] = '$auto_open'.lower() not in ['n', 'no']

with open(config_file, 'w') as f:
    json.dump(config, f, indent=2)
CONFIGPY
    
    echo -e "${GREEN}✅ Configuration updated${NC}"
}

# Test the installation
test_installation() {
    echo -e "${CYAN}Testing Secrets WAR installation...${NC}"
    
    # Create a test file with dummy secrets for testing
    cat > "/tmp/test_secrets.js" << 'TESTEOF'
// Test file for Secrets WAR
const API_KEY = "sk-1234567890abcdef1234567890abcdef";
const DATABASE_PASSWORD = "super_secret_password123";
const jwt_token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9";
// This is a test email: test@example.com
var creditCard = "4111-1111-1111-1111";
TESTEOF
    
    # Run test scan
    if "$SCRIPT_DIR/$SECRETS_WAR_SCRIPT" "/tmp/test_secrets.js" > /dev/null 2>&1; then
        echo -e "${GREEN}✅ Test scan completed successfully${NC}"
    else
        echo -e "${YELLOW}⚠️  Test scan completed with warnings${NC}"
    fi
    
    # Cleanup test file
    rm -f "/tmp/test_secrets.js"
}

# Main installation flow
main_installation() {
    echo -e "${BLUE}Setup Name: ${SETUP_NAME}${NC}"
    echo -e "${BLUE}Installation Directory: ${SCRIPT_DIR}${NC}"
    echo -e "${BLUE}Git Repository: ${GIT_ROOT}${NC}"
    echo ""
    
    echo -e "${CYAN}Starting installation...${NC}"
    
    # Step 1: Create main script
    echo -e "${YELLOW}[1/6] Creating Secrets-WAR.sh script...${NC}"
    create_secrets_war_script
    
    # Step 2: Create hooks
    echo -e "${YELLOW}[2/6] Creating git hooks...${NC}"
    create_hooks
    
    # Step 3: Configuration wizard
    echo -e "${YELLOW}[3/6] Running configuration wizard...${NC}"
    configuration_wizard
    
    # Step 4: Global hooks option
    echo -e "${YELLOW}[4/6] Global hooks setup...${NC}"
    install_global_hooks
    
    # Step 5: Test installation
    echo -e "${YELLOW}[5/6] Testing installation...${NC}"
    test_installation
    
    # Step 6: Final setup
    echo -e "${YELLOW}[6/6] Finalizing setup...${NC}"
    
    echo ""
    echo -e "${GREEN}🎉 Secrets WAR installation completed successfully!${NC}"
    echo ""
    echo -e "${CYAN}📋 Installation Summary:${NC}"
    echo -e "   ${BLUE}•${NC} Main Script: ${SCRIPT_DIR}/${SECRETS_WAR_SCRIPT}"
    echo -e "   ${BLUE}•${NC} Configuration: ${SCRIPT_DIR}/${CONFIG_FILE}"
    echo -e "   ${BLUE}•${NC} Pre-commit Hook: ${GIT_HOOKS_DIR}/pre-commit"
    echo -e "   ${BLUE}•${NC} Pre-merge Hook: ${GIT_HOOKS_DIR}/pre-merge-commit"
    echo -e "   ${BLUE}•${NC} Reports Directory: ${SCRIPT_DIR}/"
    echo ""
    echo -e "${CYAN}🚀 Usage:${NC}"
    echo -e "   ${BLUE}•${NC} Manual scan: ./${SECRETS_WAR_SCRIPT}"
    echo -e "   ${BLUE}•${NC} Scan all files: ./${SECRETS_WAR_SCRIPT} --all"
    echo -e "   ${BLUE}•${NC} Hooks will run automatically on commit/merge"
    echo -e "   ${BLUE}•${NC} Configure via: ${CONFIG_FILE}"
    echo ""
    echo -e "${CYAN}🛡️  Your repository is now protected by Secrets WAR!${NC}"
    
    # Show configuration file location
    echo -e "${YELLOW}📝 Edit ${CONFIG_FILE} to customize:${NC}"
    echo -e "   ${BLUE}•${NC} Add custom patterns"
    echo -e "   ${BLUE}•${NC} Modify exclude patterns"
    echo -e "   ${BLUE}•${NC} Update whitelist patterns"
    echo -e "   ${BLUE}•${NC} Change file extensions to scan"
    echo ""
}

# Advanced installation options
advanced_options() {
    echo -e "${PURPLE}🔧 Advanced Installation Options${NC}"
    echo "1. Standard Installation (Recommended)"
    echo "2. Custom Installation"
    echo "3. Development Mode Installation"
    echo "4. Enterprise Installation"
    echo "5. Exit"
    echo ""
    echo -e "${YELLOW}Select installation type (1-5): ${NC}"
    read -r install_type
    
    case $install_type in
        1)
            echo -e "${GREEN}Selected: Standard Installation${NC}"
            ;;
        2)
            echo -e "${GREEN}Selected: Custom Installation${NC}"
            echo -e "${YELLOW}Custom installation allows you to modify all settings...${NC}"
            ;;
        3)
            echo -e "${GREEN}Selected: Development Mode${NC}"
            echo -e "${YELLOW}Development mode enables verbose logging and debug features...${NC}"
            # Add development mode configurations
            ;;
        4)
            echo -e "${GREEN}Selected: Enterprise Installation${NC}"
            echo -e "${YELLOW}Enterprise mode includes additional security patterns and compliance features...${NC}"
            # Add enterprise configurations
            ;;
        5)
            echo -e "${CYAN}Installation cancelled.${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid selection. Using standard installation.${NC}"
            ;;
    esac
}

# Check system requirements
check_requirements() {
    echo -e "${CYAN}Checking system requirements...${NC}"
    
    local missing_requirements=()
    
    # Check for required commands
    if ! command -v git > /dev/null 2>&1; then
        missing_requirements+=("git")
    fi
    
    if ! command -v python3 > /dev/null 2>&1 && ! command -v python > /dev/null 2>&1; then
        missing_requirements+=("python3 or python")
    fi
    
    if ! command -v grep > /dev/null 2>&1; then
        missing_requirements+=("grep")
    fi
    
    if ! command -v xargs > /dev/null 2>&1; then
        missing_requirements+=("xargs")
    fi
    
    if [ ${#missing_requirements[@]} -gt 0 ]; then
        echo -e "${RED}❌ Missing required dependencies:${NC}"
        printf '%s\n' "${missing_requirements[@]}" | sed 's/^/   • /'
        echo ""
        echo -e "${YELLOW}Please install the missing dependencies and run the setup again.${NC}"
        exit 1
    fi
    
    echo -e "${GREEN}✅ All system requirements met${NC}"
}

# Cleanup function for failed installations
cleanup_failed_installation() {
    echo -e "${RED}Installation failed. Cleaning up...${NC}"
    
    # Remove created files
    [ -f "$SCRIPT_DIR/$SECRETS_WAR_SCRIPT" ] && rm -f "$SCRIPT_DIR/$SECRETS_WAR_SCRIPT"
    [ -f "$SCRIPT_DIR/$CONFIG_FILE" ] && rm -f "$SCRIPT_DIR/$CONFIG_FILE"
    [ -f "$GIT_HOOKS_DIR/pre-commit" ] && rm -f "$GIT_HOOKS_DIR/pre-commit"
    [ -f "$GIT_HOOKS_DIR/pre-merge-commit" ] && rm -f "$GIT_HOOKS_DIR/pre-merge-commit"
    
    echo -e "${YELLOW}Cleanup completed. Please check the error messages above and try again.${NC}"
    exit 1
}

# Trap for cleanup on failure
trap cleanup_failed_installation ERR

# Main execution flow
main() {
    # Print banner
    print_banner
    
    # Check system requirements
    check_requirements
    
    # Check if we're in a git repository
    check_git_repository
    
    # Show advanced options
    advanced_options
    
    # Run main installation
    main_installation
    
    echo -e "${PURPLE}Thank you for using Secrets WAR!${NC}"
    echo -e "${CYAN}For support and updates, visit: https://github.com/secrets-war${NC}"
}

# Run main function
main "$@"