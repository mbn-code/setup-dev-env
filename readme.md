# Development Environment Setup Script

This script provides an automated way to set up a comprehensive development environment on macOS. It installs essential development tools, code editors, and a variety of useful plugins and utilities.

## Features

- **Homebrew Installation**: Installs Homebrew if it's not already installed.
- **Whiptail Installation**: Installs whiptail for interactive dialogs.
- **Code Editor Selection**: Allows you to choose between installing Visual Studio Code or Neovim.
- **Neovim Configuration**: Configures Neovim with a wide range of popular plugins.
- **Visual Studio Code Extensions**: Installs useful VSCode extensions.
- **Additional Tools**: Installs a selection of useful tools and utilities.
- **Interactive User Prompts**: Asks users for their preferences and options during setup.
- **Progress Animation**: Displays a professional start screen and progress animation.

## Prerequisites

- **macOS**: The script is designed to run on macOS.
- **Internet Connection**: Required for downloading and installing packages.

## Usage

1. **Clone the Repository**

   Clone the repository to your local machine using Git:

   ```bash
   git clone https://github.com/mbn-code/setup-dev-env.git
   cd setup-dev-env
   ```

2. **Make the Script Executable**

   Change the permissions of the script to make it executable:

   ```bash
   chmod +x setup_dev_env.sh
   ```

3. **Run the Script**

   Execute the script to start the setup process:

   ```bash
   ./setup_dev_env.sh
   ```

   Follow the prompts to choose your preferred code editor, plugins, and additional tools.

## Interactive Options

- **Code Editor**: Choose between Visual Studio Code and Neovim.
- **Neovim Plugins**: Select from a wide range of Neovim plugins to install.
- **Additional Tools**: Select from various additional tools like iTerm2, Postman, Slack, and more.

## Available Plugins

The script includes support for many popular Neovim plugins:

- **vim-plug**: Plugin manager for Neovim
- **NERDTree**: File explorer
- **vim-airline**: Status line
- **fzf**: Command-line fuzzy finder
- **coc.nvim**: Intelligent autocompletion
- **lightline.vim**: Lightweight status line
- **ale**: Asynchronous linting and fixing
- **nerdcommenter**: Commenting tool
- **vim-gitgutter**: Git diff indicators
- **surround**: Surround text objects
- **auto-pairs**: Automatically insert closing pairs
- **ctrlp.vim**: Fuzzy file finder
- **vim-fugitive**: Git wrapper
- **vim-startify**: Start screen with recent files
- **telescope.nvim**: Fuzzy finder with preview
- **coc-python**: Python autocompletion and linting
- **coc-tsserver**: TypeScript and JavaScript autocompletion
- **vim-test**: Testing framework
- **vim-surround**: Manage surrounding characters
- **vim-multiple-cursors**: Support for multiple cursors
- **vim-rails**: Rails integration
- **vim-commentary**: Easier commenting
- **indent-blankline**: Indentation guides
- **startify**: Start screen for Vim

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please feel free to submit a pull request or open an issue if you have suggestions or improvements.

## Contact

For any questions or issues, please contact [malthe@mbn-code.dk](mailto:malthe@mbn-code.dk).

Happy coding!

### Notes

- Replace `https://github.com/mbn-code/setup-dev-env.git` with the actual URL of your GitHub repository.
- Update the email address in the Contact section with your actual email.
