# My config files for both linux and windows

## Table of content

- [Neovim setup](#neovim-setup)


## Neovim Setup

1. Install [Neovim 0.7.0](https://github.com/neovim/neovim/releases/tag/v0.7.0) or newer
2. Install [vim-plug](https://github.com/junegunn/vim-plug)
3. Clone the repo
  ```sh
  git clone https://github.com/DavinderJolly/myConfigs
  ```
4. Change directory into the folder
  ```sh
  cd myConfigs
  ```
4. copy the `nvim` folder to your config location
  - linux
    ```sh
    cp -r ./nvim ~/.config/nvim
    ```
  - windows
    ```powershell
    Copy-Item -Recurse ./nvim "$ENV:LOCALAPPDATA\nvim"
    ```
5. Open neovim (command to open neovim is `nvim`)
6. Install plugins in neovim by running `:PlugInstall` (more info on vim-plug's github)
7. Restart neovim to let LspInstaller and Tree-sitter auto install language servers and parsers
