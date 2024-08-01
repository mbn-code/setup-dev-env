#!/bin/bash

# Define the plugins to be added
PLUGINS=(
    "Plug 'nvim-treesitter/nvim-treesitter'"
    "Plug 'neovim/nvim-lspconfig'"
    "Plug 'hrsh7th/nvim-compe'"
    "Plug 'tpope/vim-fugitive'"
    "Plug 'junegunn/fzf.vim'"
    "Plug 'preservim/nerdtree'"
    "Plug 'kyazdani42/nvim-tree.lua'"
    "Plug 'hoob3rt/lualine.nvim'"
    "Plug 'nvim-telescope/telescope.nvim'"
    "Plug 'vim-airline/vim-airline'"
    "Plug 'jiangmiao/auto-pairs'"
    "Plug 'windwp/nvim-autopairs'"
    "Plug 'dense-analysis/ale'"
    "Plug 'airblade/vim-gitgutter'"
    "Plug 'itchyny/lightline.vim'"
    "Plug 'junegunn/goyo.vim'"
    "Plug 'vimwiki/vimwiki'"
    "Plug 'shime/vim-livedown'"
    "Plug 'vim-test/vim-test'"
    "Plug 'tpope/vim-commentary'"
)

# Path to the Neovim init.vim file
NVIM_CONFIG="$HOME/.config/nvim/init.vim"

# Backup existing init.vim
if [ -f "$NVIM_CONFIG" ]; then
    cp "$NVIM_CONFIG" "$NVIM_CONFIG.bak"
    echo "Backup of existing init.vim created at $NVIM_CONFIG.bak"
fi

# Ensure vim-plug is installed
if ! [ -f "$HOME/.local/share/nvim/site/autoload/plug.vim" ]; then
    echo "Installing vim-plug..."
    curl -fLo "$HOME/.local/share/nvim/site/autoload/plug.vim" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Add plugins to init.vim
{
    echo "\" Plugins section added by add_plugins.sh"
    echo "call plug#begin('~/.local/share/nvim/plugged')"
    for plugin in "${PLUGINS[@]}"; do
        echo "    $plugin"
    done
    echo "call plug#end()"
} >> "$NVIM_CONFIG"

echo "Plugins have been added to $NVIM_CONFIG. Run ':PlugInstall' in Neovim to install them."
