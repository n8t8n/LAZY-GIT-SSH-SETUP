#!/bin/bash

# Modern color palette with gradients and effects
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
GRAY='\033[0;37m'
BOLD='\033[1m'
DIM='\033[2m'
UNDERLINE='\033[4m'
BLINK='\033[5m'
REVERSE='\033[7m'
NC='\033[0m'

# Modern gradient colors
NEON_GREEN='\033[38;5;46m'
NEON_BLUE='\033[38;5;51m'
NEON_PINK='\033[38;5;201m'
NEON_ORANGE='\033[38;5;208m'
DARK_GRAY='\033[38;5;236m'
LIGHT_GRAY='\033[38;5;248m'
ELECTRIC_BLUE='\033[38;5;39m'

# Modern header with glassmorphism effect
show_header() {
    clear
    
    # Top border with gradient effect
    echo -e "${NEON_BLUE}╔══════════════════════════════════════╗${NC}"
    echo -e "${NEON_BLUE}║${BOLD}${WHITE}        🐈‍⬛ LAZY GIT SSH SETUP         ${NC}${NEON_BLUE}║${NC}"
    echo -e "${NEON_BLUE}╚══════════════════════════════════════╝${NC}"
    echo ""
    
    # Enhanced cat with modern styling
    echo -e "${NEON_PINK}           ╭─────────╮           ${NC}"
    echo -e "${NEON_PINK}           │${WHITE}  /\\_/\\  ${NEON_PINK}│           ${NC}"
    echo -e "${NEON_PINK}           │${WHITE} ( ${NEON_ORANGE}o.o${WHITE} ) ${NEON_PINK}│           ${NC}"
    echo -e "${NEON_PINK}           │${WHITE}  > ^ <  ${NEON_PINK}│           ${NC}"
    echo -e "${NEON_PINK}           │${WHITE} /     \\ ${NEON_PINK}│           ${NC}"
    echo -e "${NEON_PINK}           │${WHITE}(       )${NEON_PINK}│           ${NC}"
    echo -e "${NEON_PINK}           │${WHITE}( (  )  )${NEON_PINK}│           ${NC}"
    echo -e "${NEON_PINK}           │${WHITE}(__(__)_)${NEON_PINK}│           ${NC}"
    echo -e "${NEON_PINK}           ╰─────────╯           ${NC}"
    echo ""
    
    # Modern author card
    echo -e "${DARK_GRAY}╭────────────────────────────────────╮${NC}"
    echo -e "${DARK_GRAY}│${NEON_GREEN} 👨‍💻 ${BOLD}J0n47h4n V01d${NC}${DARK_GRAY}                │${NC}"
    echo -e "${DARK_GRAY}│${ELECTRIC_BLUE} 🔗 https://linkedin.com/in/jonathanvoid${NC}${DARK_GRAY} │${NC}"
    echo -e "${DARK_GRAY}│${LIGHT_GRAY} 💡 SSH setup so easy, cats can do it${NC}${DARK_GRAY}│${NC}"
    echo -e "${DARK_GRAY}╰────────────────────────────────────╯${NC}"
    echo ""
}

# Modern status indicators with enhanced icons
show_status() {
    local status=$1
    local message=$2
    case $status in
        "info")
            echo -e "${ELECTRIC_BLUE}${BOLD}ℹ️  INFO${NC} ${WHITE}${message}${NC}"
            ;;
        "success")
            echo -e "${NEON_GREEN}${BOLD}✅ SUCCESS${NC} ${WHITE}${message}${NC}"
            ;;
        "warning")
            echo -e "${NEON_ORANGE}${BOLD}⚠️  WARNING${NC} ${WHITE}${message}${NC}"
            ;;
        "error")
            echo -e "${RED}${BOLD}❌ ERROR${NC} ${WHITE}${message}${NC}"
            ;;
        "progress")
            echo -e "${NEON_BLUE}${BOLD}⏳ WORKING${NC} ${WHITE}${message}${NC}"
            ;;
    esac
}

# Futuristic progress bar
show_progress() {
    local current=$1
    local total=$2
    local width=30
    local percentage=$((current * 100 / total))
    local filled=$((width * current / total))
    
    echo ""
    echo -e "${DARK_GRAY}╭────────────────────────────────────╮${NC}"
    printf "${DARK_GRAY}│${NC} ${NEON_BLUE}PROGRESS${NC} "
    printf "${NEON_GREEN}["
    printf "%*s" $filled | tr ' ' '█'
    printf "${DARK_GRAY}%*s" $((width - filled)) | tr ' ' '░'
    printf "${NEON_GREEN}]${NC} ${BOLD}%d%%${NC} ${DARK_GRAY}│${NC}\n" $percentage
    echo -e "${DARK_GRAY}╰────────────────────────────────────╯${NC}"
    echo ""
}

# Enhanced step display
show_step() {
    local step=$1
    local title=$2
    local icon=$3
    
    show_header
    show_progress $step 4
    
    echo -e "${NEON_BLUE}╔══════════════════════════════════════╗${NC}"
    echo -e "${NEON_BLUE}║${NC} ${icon} ${BOLD}${WHITE}STEP ${step}: ${title}${NC} ${NEON_BLUE}║${NC}"
    echo -e "${NEON_BLUE}╚══════════════════════════════════════╝${NC}"
    echo ""
}

# Function to generate SSH key
generate_ssh_key() {
    show_step 1 "GENERATE SSH KEY" "🔑"
    
    while true; do
        echo -e "${NEON_PINK}╭────────────────────────────────────╮${NC}"
        echo -e "${NEON_PINK}│${NC} ${NEON_ORANGE}📧${NC} ${BOLD}Enter your email address:${NC}       ${NEON_PINK}│${NC}"
        echo -e "${NEON_PINK}╰────────────────────────────────────╯${NC}"
        echo ""
        read -p "$(echo -e "${YELLOW}✨ Email: ${NC}")" email
        
        if [[ "$email" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
            break
        else
            echo ""
            show_status "error" "Invalid email format! Try again."
            echo ""
        fi
    done
    
    echo ""
    show_status "progress" "Generating Ed25519 key..."
    
    if ssh-keygen -t ed25519 -C "$email" -f ~/.ssh/id_ed25519 -N "" > /dev/null 2>&1; then
        show_status "success" "Ed25519 key generated successfully!"
    else
        show_status "warning" "Falling back to RSA..."
        if ssh-keygen -t rsa -b 4096 -C "$email" -f ~/.ssh/id_rsa -N "" > /dev/null 2>&1; then
            show_status "success" "RSA key generated successfully!"
        else
            show_status "error" "Key generation failed completely!"
            exit 1
        fi
    fi
    
    sleep 2
}

# Function to add SSH key to SSH agent
add_ssh_to_agent() {
    show_step 2 "ADD TO SSH AGENT" "🔧"
    
    show_status "progress" "Starting SSH agent..."
    eval "$(ssh-agent -s)" > /dev/null 2>&1
    
    if [ -f ~/.ssh/id_ed25519 ]; then
        ssh-add ~/.ssh/id_ed25519 > /dev/null 2>&1
        show_status "success" "Ed25519 key added to agent!"
    elif [ -f ~/.ssh/id_rsa ]; then
        ssh-add ~/.ssh/id_rsa > /dev/null 2>&1
        show_status "success" "RSA key added to agent!"
    else
        show_status "error" "No SSH key found to add!"
        exit 1
    fi
    
    sleep 2
}

# Function to copy and display key for GitHub
add_ssh_to_github() {
    show_step 3 "ADD TO GITHUB" "🌐"
    
    local key_file=""
    if [ -f ~/.ssh/id_ed25519.pub ]; then
        key_file="~/.ssh/id_ed25519.pub"
    elif [ -f ~/.ssh/id_rsa.pub ]; then
        key_file="~/.ssh/id_rsa.pub"
    else
        show_status "error" "No public key found!"
        exit 1
    fi
    
    show_status "progress" "Copying key to clipboard..."
    
    # Try different clipboard commands
    if command -v pbcopy >/dev/null 2>&1; then
        cat $key_file | pbcopy
        show_status "success" "Key copied to clipboard! (macOS)"
    elif command -v xclip >/dev/null 2>&1; then
        cat $key_file | xclip -selection clipboard
        show_status "success" "Key copied to clipboard! (Linux)"
    elif command -v clip >/dev/null 2>&1; then
        cat $key_file | clip
        show_status "success" "Key copied to clipboard! (Windows)"
    else
        show_status "warning" "Clipboard not available, showing key:"
        echo ""
        echo -e "${DARK_GRAY}╭────────────────────────────────────╮${NC}"
        echo -e "${DARK_GRAY}│${NC} ${YELLOW}$(cat $key_file)${NC} ${DARK_GRAY}│${NC}"
        echo -e "${DARK_GRAY}╰────────────────────────────────────╯${NC}"
    fi
    
    echo ""
    echo -e "${NEON_GREEN}╔══════════════════════════════════════╗${NC}"
    echo -e "${NEON_GREEN}║${NC} ${BOLD}${WHITE}🚀 GITHUB SETUP INSTRUCTIONS${NC}      ${NEON_GREEN}║${NC}"
    echo -e "${NEON_GREEN}╠══════════════════════════════════════╣${NC}"
    echo -e "${NEON_GREEN}║${NC} ${NEON_BLUE}1.${NC} ${ELECTRIC_BLUE}🌐 github.com/settings/keys${NC}      ${NEON_GREEN}║${NC}"
    echo -e "${NEON_GREEN}║${NC} ${NEON_BLUE}2.${NC} ${ELECTRIC_BLUE}➕ Click 'New SSH key'${NC}           ${NEON_GREEN}║${NC}"
    echo -e "${NEON_GREEN}║${NC} ${NEON_BLUE}3.${NC} ${ELECTRIC_BLUE}📝 Add title (e.g., 'My Phone')${NC}  ${NEON_GREEN}║${NC}"
    echo -e "${NEON_GREEN}║${NC} ${NEON_BLUE}4.${NC} ${ELECTRIC_BLUE}📋 Paste key (already copied!)${NC}   ${NEON_GREEN}║${NC}"
    echo -e "${NEON_GREEN}║${NC} ${NEON_BLUE}5.${NC} ${ELECTRIC_BLUE}✅ Click 'Add SSH key'${NC}           ${NEON_GREEN}║${NC}"
    echo -e "${NEON_GREEN}╚══════════════════════════════════════╝${NC}"
    
    echo ""
    echo -e "${NEON_PINK}╭────────────────────────────────────╮${NC}"
    echo -e "${NEON_PINK}│${NC} ${BOLD}Press ${NEON_ORANGE}[ENTER]${NC} when complete    ${NEON_PINK}│${NC}"
    echo -e "${NEON_PINK}╰────────────────────────────────────╯${NC}"
    read
}

# Function to test SSH connection to GitHub
test_ssh_connection() {
    show_step 4 "TEST CONNECTION" "🧪"
    
    show_status "progress" "Testing GitHub SSH connection..."
    
    ssh_output=$(ssh -T git@github.com 2>&1)
    
    if echo "$ssh_output" | grep -q "successfully authenticated"; then
        echo ""
        echo -e "${NEON_GREEN}╔══════════════════════════════════════╗${NC}"
        echo -e "${NEON_GREEN}║${NC} ${BOLD}${WHITE}🎉 CONNECTION SUCCESSFUL! 🎉${NC}        ${NEON_GREEN}║${NC}"
        echo -e "${NEON_GREEN}║${NC} ${NEON_BLUE}You're ready to use GitHub SSH!${NC}      ${NEON_GREEN}║${NC}"
        echo -e "${NEON_GREEN}╚══════════════════════════════════════╝${NC}"
    else
        show_status "error" "Connection test failed!"
        echo ""
        echo -e "${RED}${BOLD}Debug output:${NC}"
        echo -e "${DARK_GRAY}${ssh_output}${NC}"
        echo ""
        echo -e "${NEON_ORANGE}╔══════════════════════════════════════╗${NC}"
        echo -e "${NEON_ORANGE}║${NC} ${BOLD}${WHITE}💡 TROUBLESHOOTING TIPS${NC}             ${NEON_ORANGE}║${NC}"
        echo -e "${NEON_ORANGE}║${NC} ${YELLOW}• Verify key was added to GitHub${NC}     ${NEON_ORANGE}║${NC}"
        echo -e "${NEON_ORANGE}║${NC} ${YELLOW}• Try: ssh -vT git@github.com${NC}        ${NEON_ORANGE}║${NC}"
        echo -e "${NEON_ORANGE}║${NC} ${YELLOW}• Check internet connection${NC}          ${NEON_ORANGE}║${NC}"
        echo -e "${NEON_ORANGE}╚══════════════════════════════════════╝${NC}"
    fi
}

# Modern main menu with card-based design
show_main_menu() {
    show_header
    
    echo -e "${BOLD}${WHITE}🎯 SELECT AN OPTION:${NC}"
    echo ""
    
    # Option cards
    echo -e "${NEON_BLUE}╭────────────────────────────────────╮${NC}"
    echo -e "${NEON_BLUE}│${NC} ${BOLD}${NEON_GREEN}1${NC} ${BOLD}│${NC} 🚀 ${BOLD}${WHITE}FULL SETUP${NC}                ${NEON_BLUE}│${NC}"
    echo -e "${NEON_BLUE}│${NC}   ${DARK_GRAY}│${NC} ${DIM}Generate + Add + Test${NC}         ${NEON_BLUE}│${NC}"
    echo -e "${NEON_BLUE}╰────────────────────────────────────╯${NC}"
    echo ""
    
    echo -e "${NEON_PINK}╭────────────────────────────────────╮${NC}"
    echo -e "${NEON_PINK}│${NC} ${BOLD}${NEON_GREEN}2${NC} ${BOLD}│${NC} 🔑 ${BOLD}${WHITE}GENERATE KEY ONLY${NC}         ${NEON_PINK}│${NC}"
    echo -e "${NEON_PINK}╰────────────────────────────────────╯${NC}"
    echo ""
    
    echo -e "${ELECTRIC_BLUE}╭────────────────────────────────────╮${NC}"
    echo -e "${ELECTRIC_BLUE}│${NC} ${BOLD}${NEON_GREEN}3${NC} ${BOLD}│${NC} 🔧 ${BOLD}${WHITE}ADD TO SSH AGENT${NC}          ${ELECTRIC_BLUE}│${NC}"
    echo -e "${ELECTRIC_BLUE}╰────────────────────────────────────╯${NC}"
    echo ""
    
    echo -e "${NEON_ORANGE}╭────────────────────────────────────╮${NC}"
    echo -e "${NEON_ORANGE}│${NC} ${BOLD}${NEON_GREEN}4${NC} ${BOLD}│${NC} 🧪 ${BOLD}${WHITE}TEST CONNECTION${NC}           ${NEON_ORANGE}│${NC}"
    echo -e "${NEON_ORANGE}╰────────────────────────────────────╯${NC}"
    echo ""
    
    echo -e "${PURPLE}╭────────────────────────────────────╮${NC}"
    echo -e "${PURPLE}│${NC} ${BOLD}${NEON_GREEN}5${NC} ${BOLD}│${NC} 📋 ${BOLD}${WHITE}SHOW PUBLIC KEY${NC}           ${PURPLE}│${NC}"
    echo -e "${PURPLE}╰────────────────────────────────────╯${NC}"
    echo ""
    
    echo -e "${DARK_GRAY}╭────────────────────────────────────╮${NC}"
    echo -e "${DARK_GRAY}│${NC} ${BOLD}${RED}6${NC} ${BOLD}│${NC} 🚪 ${BOLD}${WHITE}EXIT${NC}                      ${DARK_GRAY}│${NC}"
    echo -e "${DARK_GRAY}╰────────────────────────────────────╯${NC}"
    echo ""
    
    read -p "$(echo -e "${YELLOW}${BOLD}⚡ Choice [1-6]: ${NC}")" choice
}

# Function to show public key with modern styling
show_public_key() {
    show_header
    
    echo -e "${NEON_BLUE}╔══════════════════════════════════════╗${NC}"
    echo -e "${NEON_BLUE}║${NC} ${BOLD}${WHITE}📋 YOUR PUBLIC SSH KEY${NC}              ${NEON_BLUE}║${NC}"
    echo -e "${NEON_BLUE}╚══════════════════════════════════════╝${NC}"
    echo ""
    
    if [ -f ~/.ssh/id_ed25519.pub ]; then
        echo -e "${NEON_GREEN}${BOLD}🔐 Ed25519 Key:${NC}"
        echo -e "${DARK_GRAY}╭────────────────────────────────────╮${NC}"
        echo -e "${DARK_GRAY}│${NC} ${YELLOW}$(cat ~/.ssh/id_ed25519.pub)${NC} ${DARK_GRAY}│${NC}"
        echo -e "${DARK_GRAY}╰────────────────────────────────────╯${NC}"
    elif [ -f ~/.ssh/id_rsa.pub ]; then
        echo -e "${NEON_GREEN}${BOLD}🔐 RSA Key:${NC}"
        echo -e "${DARK_GRAY}╭────────────────────────────────────╮${NC}"
        echo -e "${DARK_GRAY}│${NC} ${YELLOW}$(cat ~/.ssh/id_rsa.pub)${NC} ${DARK_GRAY}│${NC}"
        echo -e "${DARK_GRAY}╰────────────────────────────────────╯${NC}"
    else
        show_status "error" "No public key found!"
    fi
    
    echo ""
    echo -e "${NEON_PINK}╭────────────────────────────────────╮${NC}"
    echo -e "${NEON_PINK}│${NC} ${BOLD}Press ${NEON_ORANGE}[ENTER]${NC} to continue       ${NEON_PINK}│${NC}"
    echo -e "${NEON_PINK}╰────────────────────────────────────╯${NC}"
    read
}

# Completion screen
show_completion() {
    show_header
    
    echo -e "${NEON_GREEN}╔══════════════════════════════════════╗${NC}"
    echo -e "${NEON_GREEN}║${NC} ${BOLD}${WHITE}🎉 SETUP COMPLETE! 🎉${NC}               ${NEON_GREEN}║${NC}"
    echo -e "${NEON_GREEN}╠══════════════════════════════════════╣${NC}"
    echo -e "${NEON_GREEN}║${NC} ${NEON_BLUE}✅ SSH key generated${NC}                ${NEON_GREEN}║${NC}"
    echo -e "${NEON_GREEN}║${NC} ${NEON_BLUE}✅ Added to SSH agent${NC}               ${NEON_GREEN}║${NC}"
    echo -e "${NEON_GREEN}║${NC} ${NEON_BLUE}✅ GitHub connection tested${NC}         ${NEON_GREEN}║${NC}"
    echo -e "${NEON_GREEN}║${NC}                                    ${NEON_GREEN}║${NC}"
    echo -e "${NEON_GREEN}║${NC} ${BOLD}${WHITE}🚀 Ready to clone with SSH!${NC}        ${NEON_GREEN}║${NC}"
    echo -e "${NEON_GREEN}╚══════════════════════════════════════╝${NC}"
    
    echo ""
    echo -e "${NEON_PINK}╭────────────────────────────────────╮${NC}"
    echo -e "${NEON_PINK}│${NC} ${BOLD}Press ${NEON_ORANGE}[ENTER]${NC} for main menu     ${NEON_PINK}│${NC}"
    echo -e "${NEON_PINK}╰────────────────────────────────────╯${NC}"
    read
}

# Main script execution
main() {
    while true; do
        show_main_menu
        
        case $choice in
            1)
                generate_ssh_key
                add_ssh_to_agent
                add_ssh_to_github
                test_ssh_connection
                show_completion
                ;;
            2)
                generate_ssh_key
                echo ""
                echo -e "${NEON_PINK}╭────────────────────────────────────╮${NC}"
                echo -e "${NEON_PINK}│${NC} ${BOLD}Press ${NEON_ORANGE}[ENTER]${NC} for main menu     ${NEON_PINK}│${NC}"
                echo -e "${NEON_PINK}╰────────────────────────────────────╯${NC}"
                read
                ;;
            3)
                add_ssh_to_agent
                echo ""
                echo -e "${NEON_PINK}╭────────────────────────────────────╮${NC}"
                echo -e "${NEON_PINK}│${NC} ${BOLD}Press ${NEON_ORANGE}[ENTER]${NC} for main menu     ${NEON_PINK}│${NC}"
                echo -e "${NEON_PINK}╰────────────────────────────────────╯${NC}"
                read
                ;;
            4)
                test_ssh_connection
                echo ""
                echo -e "${NEON_PINK}╭────────────────────────────────────╮${NC}"
                echo -e "${NEON_PINK}│${NC} ${BOLD}Press ${NEON_ORANGE}[ENTER]${NC} for main menu     ${NEON_PINK}│${NC}"
                echo -e "${NEON_PINK}╰────────────────────────────────────╯${NC}"
                read
                ;;
            5)
                show_public_key
                ;;
            6)
                show_header
                echo -e "${NEON_GREEN}╔══════════════════════════════════════╗${NC}"
                echo -e "${NEON_GREEN}║${NC} ${BOLD}${WHITE}👋 Thanks for using Git SSH Wizard!${NC} ${NEON_GREEN}║${NC}"
                echo -e "${NEON_GREEN}║${NC} ${NEON_BLUE}🚀 Now go build something amazing!${NC}    ${NEON_GREEN}║${NC}"
                echo -e "${NEON_GREEN}╚══════════════════════════════════════╝${NC}"
                echo ""
                exit 0
                ;;
            *)
                echo ""
                show_status "error" "Invalid choice! Select 1-6 only."
                sleep 2
                ;;
        esac
    done
}

# Run the main function
main