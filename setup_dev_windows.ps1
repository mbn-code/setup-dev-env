# Exit immediately if a command exits with a non-zero status
$ErrorActionPreference = "Stop"

# Function to display a banner
function Display-Banner {
    Clear-Host
    Write-Host -ForegroundColor Blue -NoNewline "
  _____                _           _
 / ____|              | |         | |
| |  __  ___   ___   | |_   _ ___ | |
| | |_ |/ _ \ / _ \  | | | | / _ \| |
| |__| | (_) | (_) | | |_| |  __/| |
 \____/ \___/ \___/   \__,_|\___/|_|
"
    Write-Host -ForegroundColor Green "Welcome to the Development Environment Setup Script"
    Write-Host
    Write-Host "Setting up your development environment..."
    Start-Sleep -Seconds 2
}

# Function to display a progress animation
function Display-Progress {
    Write-Host -NoNewline "Processing"
    1..3 | ForEach-Object {
        Start-Sleep -Seconds 1
        Write-Host -NoNewline "."
    }
    Write-Host
}

# Function to install Chocolatey
function Install-Chocolatey {
    Write-Host "Checking for Chocolatey..."
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "Chocolatey not found. Installing Chocolatey..."
        Set-ExecutionPolicy Bypass -Scope Process -Force
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    } else {
        Write-Host "Chocolatey is already installed."
    }
}

# Function to install a tool using Chocolatey
function Install-Tool {
    param (
        [string]$tool,
        [string]$chocoName
    )
    Write-Host "Checking for $tool..."
    if (-not (Get-Command $tool -ErrorAction SilentlyContinue)) {
        Write-Host "$tool not found. Installing $tool..."
        choco install $chocoName -y
    } else {
        Write-Host "$tool is already installed."
    }
}

# Function to install Neovim
function Install-Neovim {
    Write-Host "Installing Neovim..."
    choco install neovim -y
}

# Function to install Neovim plugins
function Install-NeovimPlugins {
    Write-Host "Configuring Neovim..."
    $nvimConfigPath = "$env:USERPROFILE\AppData\Local\nvim\init.vim"
    New-Item -ItemType Directory -Force -Path (Split-Path $nvimConfigPath)
    Set-Content -Path $nvimConfigPath -Value @"
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
"@

    $plugins = @(
        @{Name="vim-plug"; Description="Plugin manager for Neovim"},
        @{Name="NERDTree"; Description="File explorer"},
        @{Name="vim-airline"; Description="Status line"},
        @{Name="fzf"; Description="Command-line fuzzy finder"},
        @{Name="coc.nvim"; Description="Intelligent autocompletion"},
        @{Name="lightline.vim"; Description="Lightweight status line"},
        @{Name="ale"; Description="Asynchronous linting and fixing"},
        @{Name="nerdcommenter"; Description="Commenting tool"},
        @{Name="vim-gitgutter"; Description="Git diff indicators"},
        @{Name="surround"; Description="Surround text objects"},
        @{Name="auto-pairs"; Description="Automatically insert closing pairs"},
        @{Name="ctrlp.vim"; Description="Fuzzy file finder"},
        @{Name="vim-fugitive"; Description="Git wrapper"},
        @{Name="vim-startify"; Description="Start screen with recent files"},
        @{Name="telescope.nvim"; Description="Fuzzy finder with preview"},
        @{Name="coc-python"; Description="Python autocompletion and linting"},
        @{Name="coc-tsserver"; Description="TypeScript and JavaScript autocompletion"},
        @{Name="vim-test"; Description="Testing framework"},
        @{Name="vim-multiple-cursors"; Description="Multiple cursors support"},
        @{Name="vim-rails"; Description="Rails integration"},
        @{Name="vim-commentary"; Description="Easier commenting"},
        @{Name="indent-blankline"; Description="Show indentation guides"},
        @{Name="vim-go"; Description="Go development plugin"},
        @{Name="deoplete"; Description="Asynchronous completion framework"},
        @{Name="vim-markdown"; Description="Markdown support"},
        @{Name="vim-sneak"; Description="Jump to any location specified by two characters"},
        @{Name="youcompleteme"; Description="Code completion engine"},
        @{Name="vim-tmux-navigator"; Description="Seamless navigation between tmux panes and vim splits"},
        @{Name="vim-javascript"; Description="JavaScript syntax highlighting"},
        @{Name="onedark.vim"; Description="Atom's iconic One Dark theme"}
    )

    $pluginChoices = $plugins | ForEach-Object {
        [PSCustomObject]@{Name=$_.Name; Description=$_.Description}
    }

    $selection = $pluginChoices | Out-GridView -Title "Select Neovim plugins to install" -PassThru


    

    if ($selection) {
        $selection | ForEach-Object {
            $plugin = $_.Name
            $pluginLine = ""
            switch ($plugin) {
                "vim-plug" { $pluginLine = "Plug 'junegunn/vim-plug'" }
                "NERDTree" { $pluginLine = "Plug 'preservim/nerdtree'" }
                "vim-airline" { $pluginLine = "Plug 'vim-airline/vim-airline'" }
                "fzf" { $pluginLine = "Plug 'junegunn/fzf'" }
                "coc.nvim" { $pluginLine = "Plug 'neoclide/coc.nvim', {'branch': 'release'}" }
                "lightline.vim" { $pluginLine = "Plug 'itchyny/lightline.vim'" }
                "ale" { $pluginLine = "Plug 'dense-analysis/ale'" }
                "nerdcommenter" { $pluginLine = "Plug 'preservim/nerdcommenter'" }
                "vim-gitgutter" { $pluginLine = "Plug 'airblade/vim-gitgutter'" }
                "surround" { $pluginLine = "Plug 'tpope/vim-surround'" }
                "auto-pairs" { $pluginLine = "Plug 'jiangmiao/auto-pairs'" }
                "ctrlp.vim" { $pluginLine = "Plug 'ctrlpvim/ctrlp.vim'" }
                "vim-fugitive" { $pluginLine = "Plug 'tpope/vim-fugitive'" }
                "vim-startify" { $pluginLine = "Plug 'mhinz/vim-startify'" }
                "telescope.nvim" { $pluginLine = "Plug 'nvim-telescope/telescope.nvim', { 'do': ':UpdateRemotePlugins' }" }
                "coc-python" { $pluginLine = "Plug 'neoclide/coc-python', {'branch': 'release'}" }
                "coc-tsserver" { $pluginLine = "Plug 'neoclide/coc-tsserver', {'branch': 'release'}" }
                "vim-test" { $pluginLine = "Plug 'vim-test/vim-test'" }
                "vim-multiple-cursors" { $pluginLine = "Plug 'terryma/vim-multiple-cursors'" }
                "vim-rails" { $pluginLine = "Plug 'tpope/vim-rails'" }
                "vim-commentary" { $pluginLine = "Plug 'tpope/vim-commentary'" }
                "indent-blankline" { $pluginLine = "Plug 'lukas-reineke/indent-blankline.nvim'" }
                "vim-go" { $pluginLine = "Plug 'fatih/vim-go'" }
                "deoplete" { $pluginLine = "Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}" }
                "vim-markdown" { $pluginLine = "Plug 'godlygeek/tabular'; Plug 'plasticboy/vim-markdown'" }
                "vim-sneak" { $pluginLine = "Plug 'justinmk/vim-sneak'" }
                "youcompleteme" { $pluginLine = "Plug 'ycm-core/YouCompleteMe', { 'do': './install.py' }" }
                "vim-tmux-navigator" { $pluginLine = "Plug 'christoomey/vim-tmux-navigator'" }
                "vim-javascript" { $pluginLine = "Plug 'pangloss/vim-javascript'" }
                "onedark.vim" { $pluginLine = "Plug 'joshdick/onedark.vim'" }
                default { Write-Warning "Unknown plugin: $plugin" }
            }
            Add-Content -Path $nvimConfigPath -Value $pluginLine
        }

        Add-Content -Path $nvimConfigPath -Value @"
call plug#end()
"@

        # Install plugins
        & nvim +PlugInstall +qall
    } else {
        Write-Host "No plugins selected."
    }
}

# Call the function to install plugins
Install-NeovimPlugins


# Function to install tools
function Install-DevelopmentTools {
    Install-Tool -tool "Git" -chocoName "git"
    Install-Tool -tool "Curl" -chocoName "curl"
    Install-Tool -tool "HTop" -chocoName "htop"
    Install-Tool -tool "Node.js" -chocoName "nodejs"
    Install-Tool -tool "Windows Terminal" -chocoName "microsoft-windows-terminal"
    Install-Tool -tool "Fira Code font" -chocoName "firacode"
}

# Main script
Display-Banner
Display-Progress
Install-Chocolatey
Install-DevelopmentTools
Install-Neovim
Install-NeovimPlugins
Write-Host "Setup complete!"
