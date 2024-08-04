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

# Function to add Homebrew to PATH
add_brew_to_path() {
    echo "Adding Homebrew to PATH..."
    if ! grep -q 'brew' ~/.zshrc && ! grep -q 'brew' ~/.bash_profile; then
        echo 'export PATH="/opt/homebrew/bin:$PATH"' >> ~/.zshrc
        echo 'export PATH="/opt/homebrew/bin:$PATH"' >> ~/.bash_profile
        source ~/.zshrc
        source ~/.bash_profile
    fi
}

# Function to install Homebrew
install_homebrew() {
    echo "Checking for Homebrew..."
    if ! command -v brew &> /dev/null; then
        echo "Homebrew not found. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        add_brew_to_path
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
                echo "Plug 'Shougo/deoplete.nvim'" >> ~/.config/nvim/init.vim
                ;;
            "\"vim-markdown\"")
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
    echo "Neovim configuration complete."

    echo "Installing Neovim plugins..."
    nvim +PlugInstall +qall
}

# Function to install Visual Studio Code
install_vscode() {
    echo "Installing Visual Studio Code..."
    brew install --cask visual-studio-code
}

# Function to install VSCode extensions
install_vscode_extensions() {
    echo "Installing VSCode extensions..."
    code --install-extension ms-python.python
    code --install-extension dbaeumer.vscode-eslint
    code --install-extension esbenp.prettier-vscode
    code --install-extension ms-vscode.cpptools
    code --install-extension editorconfig.editorconfig
    code --install-extension gitlab.gitlab-workflow
}

# Function to install additional tools
install_additional_tools() {
    echo "Installing additional tools..."
    tools=$(whiptail --title "Additional Tools" --checklist \
    "Select additional tools to install:" 20 78 15 \
    "docker" "Container platform" OFF \
    "kubernetes-cli" "Kubernetes command-line tool" OFF \
    "awscli" "AWS command-line interface" OFF \
    "terraform" "Infrastructure as code tool" OFF \
    "jq" "Command-line JSON processor" OFF \
    "git" "Version control system" ON \
    "curl" "Command-line tool for transferring data" ON \
    "wget" "Network downloader" OFF \
    "node" "JavaScript runtime" OFF \
    "python" "Python interpreter" OFF \
    "golang" "Go programming language" OFF \
    "ruby" "Ruby programming language" OFF \
    "vim" "Vi IMproved" OFF \
    "tmux" "Terminal multiplexer" OFF \
    "htop" "Interactive process viewer" OFF \
    "nmap" "Network exploration tool" OFF \
    "httpie" "Command-line HTTP client" OFF \
    "postman" "API client" OFF \
    "diff-so-fancy" "Better diffs" OFF \
    "warp" "Modern terminal" OFF \
    3>&1 1>&2 2>&3)

    for tool in $tools; do
        case $tool in
            "\"docker\"")
                check_install docker "brew install docker"
                ;;
            "\"kubernetes-cli\"")
                check_install kubectl "brew install kubernetes-cli"
                ;;
            "\"awscli\"")
                check_install aws "brew install awscli"
                ;;
            "\"terraform\"")
                check_install terraform "brew install terraform"
                ;;
            "\"jq\"")
                check_install jq "brew install jq"
                ;;
            "\"git\"")
                check_install git "brew install git"
                ;;
            "\"curl\"")
                check_install curl "brew install curl"
                ;;
            "\"wget\"")
                check_install wget "brew install wget"
                ;;
            "\"node\"")
                check_install node "brew install node"
                ;;
            "\"python\"")
                check_install python "brew install python"
                ;;
            "\"golang\"")
                check_install go "brew install golang"
                ;;
            "\"ruby\"")
                check_install ruby "brew install ruby"
                ;;
            "\"vim\"")
                check_install vim "brew install vim"
                ;;
            "\"tmux\"")
                check_install tmux "brew install tmux"
                ;;
            "\"htop\"")
                check_install htop "brew install htop"
                ;;
            "\"nmap\"")
                check_install nmap "brew install nmap"
                ;;
            "\"httpie\"")
                check_install http "brew install httpie"
                ;;
            "\"postman\"")
                check_install postman "brew install --cask postman"
                ;;
            "\"diff-so-fancy\"")
                check_install diff-so-fancy "brew install diff-so-fancy"
                ;;
            "\"warp\"")
                check_install warp "brew install --cask warp"
                ;;
        esac
    done
}

# Function to run Homebrew cleanup
run_homebrew_cleanup() {
    echo "Running Homebrew cleanup..."
    brew cleanup
}

# Main script execution
display_banner
install_homebrew
install_whiptail

# Prompt user to choose editors
editors=$(whiptail --title "Choose Editors" --checklist \
"Select editors to install:" 20 78 15 \
"nvim" "Neovim" OFF \
"vscode" "Visual Studio Code" OFF \
3>&1 1>&2 2>&3)

if echo "$editors" | grep -q '"nvim"'; then
    install_nvim
    install_nvim_plugins
fi

if echo "$editors" | grep -q '"vscode"'; then
    install_vscode
    install_vscode_extensions
fi

install_additional_tools
run_homebrew_cleanup

echo "Setup completed successfully!"
