#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Function to display a banner
display_banner() {
    clear
    echo -e "\e[1;34m"
    echo "  _____                _           _"
    echo " / ____|              | |         | |"
    echo "| |  __  ___   ___   | |_   _ ___ | |"
    echo "| | |_ |/ _ \ / _ \  | | | | / _ \| |"
    echo "| |__| | (_) | (_) | | |_| |  __/| |"
    echo " \____/ \___/ \___/   \__,_|\___/|_|"
    echo
    echo -e "\e[0m"
    echo -e "\e[1;32mWelcome to the Development Environment Setup Script\e[0m"
    echo
    echo "Setting up your development environment..."
    sleep 2
}

# Function to display a progress animation
display_progress() {
    echo -n "Processing"
    for i in {1..3}; do
        sleep 1
        echo -n "."
    done
    echo ""
}

# Function to install Homebrew
install_homebrew() {
    echo "Checking for Homebrew..."
    if ! command -v brew &> /dev/null; then
        echo "Homebrew not found. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        echo "Homebrew is already installed."
    fi
}

# Function to install whiptail
install_whiptail() {
    echo "Checking for whiptail..."
    if ! command -v whiptail &> /dev/null; then
        echo "whiptail not found. Installing whiptail..."
        brew install newt
    else
        echo "whiptail is already installed."
    fi
}

# Function to check if a tool is already installed and prompt the user
check_install() {
    tool=$1
    install_command=$2

    if command -v $tool &> /dev/null; then
        if whiptail --title "Reinstall $tool" --yesno "$tool is already installed. Do you want to reinstall it?" 10 60; then
            eval $install_command
        else
            echo "Keeping the current version of $tool."
        fi
    else
        eval $install_command
    fi
}

# Function to install Neovim
install_nvim() {
    echo "Installing Neovim..."
    brew install neovim
}

# Function to install Neovim plugins
install_nvim_plugins() {
    echo "Configuring Neovim..."
    mkdir -p ~/.config/nvim
    cat << EOF > ~/.config/nvim/init.vim
" Basic Neovim configuration
set number
syntax on
set expandtab
set tabstop=4
set shiftwidth=4
filetype plugin indent on

" Install vim-plug for plugin management
call plug#begin('~/.vim/plugged')

" Add plugins here
EOF

    plugins=$(whiptail --title "Neovim Plugins" --checklist \
    "Select Neovim plugins to install:" 20 78 15 \
    "vim-plug" "Plugin manager for Neovim" ON \
    "NERDTree" "File explorer" OFF \
    "vim-airline" "Status line" OFF \
    "fzf" "Command-line fuzzy finder" OFF \
    "coc.nvim" "Intelligent autocompletion" OFF \
    "lightline.vim" "Lightweight status line" OFF \
    "ale" "Asynchronous linting and fixing" OFF \
    "nerdcommenter" "Commenting tool" OFF \
    "vim-gitgutter" "Git diff indicators" OFF \
    "surround" "Surround text objects" OFF \
    "auto-pairs" "Automatically insert closing pairs" OFF \
    "ctrlp.vim" "Fuzzy file finder" OFF \
    "vim-fugitive" "Git wrapper" OFF \
    "vim-startify" "Start screen with recent files" OFF \
    "telescope.nvim" "Fuzzy finder with preview" OFF \
    "coc-python" "Python autocompletion and linting" OFF \
    "coc-tsserver" "TypeScript and JavaScript autocompletion" OFF \
    "vim-test" "Testing framework" OFF \
    "vim-surround" "Surround text objects" OFF \
    "vim-multiple-cursors" "Multiple cursors support" OFF \
    "vim-rails" "Rails integration" OFF \
    "vim-commentary" "Easier commenting" OFF \
    "indent-blankline" "Show indentation guides" OFF \
    "startify" "Start screen for Vim" OFF \
    "vim-go" "Go development plugin" OFF \
    "deoplete" "Asynchronous completion framework" OFF \
    "vim-markdown" "Markdown support" OFF \
    "vim-sneak" "Jump to any location specified by two characters" OFF \
    "youcompleteme" "Code completion engine" OFF \
    "vim-tmux-navigator" "Seamless navigation between tmux panes and vim splits" OFF \
    "vim-javascript" "JavaScript syntax highlighting" OFF \
    "onedark.vim" "Atom's iconic One Dark theme" OFF \
    3>&1 1>&2 2>&3)

    for plugin in $plugins; do
        case $plugin in
            "\"vim-plug\"")
                echo "Plug 'junegunn/vim-plug'" >> ~/.config/nvim/init.vim
                ;;
            "\"NERDTree\"")
                echo "Plug 'preservim/nerdtree'" >> ~/.config/nvim/init.vim
                ;;
            "\"vim-airline\"")
                echo "Plug 'vim-airline/vim-airline'" >> ~/.config/nvim/init.vim
                ;;
            "\"fzf\"")
                echo "Plug 'junegunn/fzf'" >> ~/.config/nvim/init.vim
                ;;
            "\"coc.nvim\"")
                echo "Plug 'neoclide/coc.nvim', {'branch': 'release'}" >> ~/.config/nvim/init.vim
                ;;
            "\"lightline.vim\"")
                echo "Plug 'itchyny/lightline.vim'" >> ~/.config/nvim/init.vim
                ;;
            "\"ale\"")
                echo "Plug 'dense-analysis/ale'" >> ~/.config/nvim/init.vim
                ;;
            "\"nerdcommenter\"")
                echo "Plug 'preservim/nerdcommenter'" >> ~/.config/nvim/init.vim
                ;;
            "\"vim-gitgutter\"")
                echo "Plug 'airblade/vim-gitgutter'" >> ~/.config/nvim/init.vim
                ;;
            "\"surround\"")
                echo "Plug 'tpope/vim-surround'" >> ~/.config/nvim/init.vim
                ;;
            "\"auto-pairs\"")
                echo "Plug 'jiangmiao/auto-pairs'" >> ~/.config/nvim/init.vim
                ;;
            "\"ctrlp.vim\"")
                echo "Plug 'ctrlpvim/ctrlp.vim'" >> ~/.config/nvim/init.vim
                ;;
            "\"vim-fugitive\"")
                echo "Plug 'tpope/vim-fugitive'" >> ~/.config/nvim/init.vim
                ;;
            "\"vim-startify\"")
                echo "Plug 'mhinz/vim-startify'" >> ~/.config/nvim/init.vim
                ;;
            "\"telescope.nvim\"")
                echo "Plug 'nvim-telescope/telescope.nvim', { 'do': ':UpdateRemotePlugins' }" >> ~/.config/nvim/init.vim
                ;;
            "\"coc-python\"")
                echo "Plug 'neoclide/coc-python', {'branch': 'release'}" >> ~/.config/nvim/init.vim
                ;;
            "\"coc-tsserver\"")
                echo "Plug 'neoclide/coc-tsserver', {'branch': 'release'}" >> ~/.config/nvim/init.vim
                ;;
            "\"vim-test\"")
                echo "Plug 'vim-test/vim-test'" >> ~/.config/nvim/init.vim
                ;;
            "\"vim-surround\"")
                echo "Plug 'tpope/vim-surround'" >> ~/.config/nvim/init.vim
                ;;
            "\"vim-multiple-cursors\"")
                echo "Plug 'terryma/vim-multiple-cursors'" >> ~/.config/nvim/init.vim
                ;;
            "\"vim-rails\"")
                echo "Plug 'tpope/vim-rails'" >> ~/.config/nvim/init.vim
                ;;
            "\"vim-commentary\"")
                echo "Plug 'tpope/vim-commentary'" >> ~/.config/nvim/init.vim
                ;;
            "\"indent-blankline\"")
                echo "Plug 'lukas-reineke/indent-blankline.nvim'" >> ~/.config/nvim/init.vim
                ;;
            "\"startify\"")
                echo "Plug 'mhinz/vim-startify'" >> ~/.config/nvim/init.vim
                ;;
            "\"vim-go\"")
                echo "Plug 'fatih/vim-go'" >> ~/.config/nvim/init.vim
                ;;
            "\"deoplete\"")
                echo "Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}" >> ~/.config/nvim/init.vim
                ;;
            "\"vim-markdown\"")
                echo "Plug 'godlygeek/tabular'"
                echo "Plug 'plasticboy/vim-markdown'" >> ~/.config/nvim/init.vim
                ;;
            "\"vim-sneak\"")
                echo "Plug 'justinmk/vim-sneak'" >> ~/.config/nvim/init.vim
                ;;
            "\"youcompleteme\"")
                echo "Plug 'ycm-core/YouCompleteMe'" >> ~/.config/nvim/init.vim
                ;;
            "\"vim-tmux-navigator\"")
                echo "Plug 'christoomey/vim-tmux-navigator'" >> ~/.config/nvim/init.vim
                ;;
            "\"vim-javascript\"")
                echo "Plug 'pangloss/vim-javascript'" >> ~/.config/nvim/init.vim
                ;;
            "\"onedark.vim\"")
                echo "Plug 'joshdick/onedark.vim'" >> ~/.config/nvim/init.vim
                ;;
        esac
    done

    echo "call plug#end()" >> ~/.config/nvim/init.vim

    echo "Installing Neovim plugins..."
    nvim +PlugInstall +qall
}

# Function to install Visual Studio Code
install_vscode() {
    echo "Installing Visual Studio Code..."
    brew install --cask visual-studio-code

    echo "Installing useful VSCode extensions..."
    code --install-extension ms-python.python
    code --install-extension rust-lang.rust
    code --install-extension ms-vscode.cpptools
    code --install-extension esbenp.prettier-vscode
    code --install-extension dbaeumer.vscode-eslint
    code --install-extension ritwickdey.liveserver
    code --install-extension eamodio.gitlens
}

# Function to install additional nice-to-have tools
install_additional_tools() {
    echo "Installing additional nice-to-have tools..."
    echo "Additional tools available:"
    echo "1. iterm2 - Terminal replacement"
    echo "2. postman - API development"
    echo "3. slack - Team communication"
    echo "4. zoom - Video conferencing"
    echo "5. google-chrome - Web browser"
    echo "6. htop - System monitoring"
    echo "7. git - Version control"
    echo "8. tree - Directory listing"
    echo "9. jq - JSON processing"
    echo "10. docker - Containerization platform"
    echo "11. aws-cli - AWS command line interface"
    echo "12. kubectl - Kubernetes command line tool"
    echo "13. helm - Kubernetes package manager"
    echo "14. terraform - Infrastructure as code"
    echo "15. ansible - IT automation tool"
    echo "16. vim - Text editor"
    echo "17. wget - Network downloader"
    echo "18. curl - Data transfer tool"
    echo "19. httpie - User-friendly HTTP client"
    echo "20. tmux - Terminal multiplexer"
    echo "21. zsh - Shell"
    echo "22. oh-my-zsh - Zsh configuration framework"
    echo "23. node - JavaScript runtime"
    echo "24. yarn - JavaScript package manager"
    
    additional_tools=$(whiptail --title "Additional Tools" --checklist \
    "Select additional tools to install:" 20 78 15 \
    "iterm2" "Terminal replacement" OFF \
    "postman" "API development" OFF \
    "slack" "Team communication" OFF \
    "zoom" "Video conferencing" OFF \
    "google-chrome" "Web browser" OFF \
    "htop" "System monitoring" OFF \
    "git" "Version control" OFF \
    "tree" "Directory listing" OFF \
    "jq" "JSON processing" OFF \
    "docker" "Containerization platform" OFF \
    "aws-cli" "AWS command line interface" OFF \
    "kubectl" "Kubernetes command line tool" OFF \
    "helm" "Kubernetes package manager" OFF \
    "terraform" "Infrastructure as code" OFF \
    "ansible" "IT automation tool" OFF \
    "vim" "Text editor" OFF \
    "wget" "Network downloader" OFF \
    "curl" "Data transfer tool" OFF \
    "httpie" "User-friendly HTTP client" OFF \
    "tmux" "Terminal multiplexer" OFF \
    "zsh" "Shell" OFF \
    "oh-my-zsh" "Zsh configuration framework" OFF \
    "node" "JavaScript runtime" OFF \
    "yarn" "JavaScript package manager" OFF \
    3>&1 1>&2 2>&3)

    for tool in $additional_tools; do
        case $tool in
            "\"iterm2\"")
                brew install --cask iterm2
                ;;
            "\"postman\"")
                brew install --cask postman
                ;;
            "\"slack\"")
                brew install --cask slack
                ;;
            "\"zoom\"")
                brew install --cask zoom
                ;;
            "\"google-chrome\"")
                brew install --cask google-chrome
                ;;
            "\"htop\"")
                brew install htop
                ;;
            "\"git\"")
                brew install git
                ;;
            "\"tree\"")
                brew install tree
                ;;
            "\"jq\"")
                brew install jq
                ;;
            "\"docker\"")
                brew install --cask docker
                ;;
            "\"aws-cli\"")
                brew install awscli
                ;;
            "\"kubectl\"")
                brew install kubectl
                ;;
            "\"helm\"")
                brew install helm
                ;;
            "\"terraform\"")
                brew install terraform
                ;;
            "\"ansible\"")
                brew install ansible
                ;;
            "\"vim\"")
                brew install vim
                ;;
            "\"wget\"")
                brew install wget
                ;;
            "\"curl\"")
                brew install curl
                ;;
            "\"httpie\"")
                brew install httpie
                ;;
            "\"tmux\"")
                brew install tmux
                ;;
            "\"zsh\"")
                brew install zsh
                ;;
            "\"oh-my-zsh\"")
                sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
                ;;
            "\"node\"")
                brew install node
                ;;
            "\"yarn\"")
                brew install yarn
                ;;
        esac
    done
}

# Display the banner and animation
display_banner
display_progress

# Install Homebrew and whiptail first
install_homebrew
install_whiptail

# Display progress animation
display_progress

# Ask user to choose between Visual Studio Code or Neovim
editor_choice=$(whiptail --title "Code Editor" --radiolist \
"Select the code editor to install:" 20 78 15 \
"Visual Studio Code" "The popular code editor" ON \
"Neovim" "The modern Vim-based editor" OFF \
3>&1 1>&2 2>&3)

# Install the selected code editor and configure it
case $editor_choice in
    "Visual Studio Code")
        install_vscode
        ;;
    "Neovim")
        install_nvim
        if whiptail --title "Neovim Plugins" --yesno "Do you want to install Neovim plugins?" 10 60; then
            install_nvim_plugins
        fi
        ;;
esac

# Install additional nice-to-have tools
install_additional_tools

# Clean up
echo "Cleaning up..."
brew cleanup

echo "Development environment setup is complete!"
echo "You may need to restart your terminal or source your profile for some changes to take effect."
