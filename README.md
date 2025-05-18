# 🚀 Neovim Basic

- Typescript / Javascript / React and more
- Package manager [Lazy.nvim](https://github.com/folke/lazy.nvim)
- LSP
- Prettier
- Snippets
- Luanine
- Git
- Linter
- ...

## About

This configuration is based on [josean-dev](https://github.com/josean-dev/dev-environment-files), [ThePrimeagen](https://github.com/ThePrimeagen/init.lua/tree/249f3b14cc517202c80c6babd0f9ec548351ec71/after/plugin) and [miltonllera/config](https://github.com/miltonllera/neovim-config), however some shortcuts have been changed and some plugins have been organized to work on projects with typescript, javascript and react.

## History

I have been using [coc.nvim](https://github.com/neoclide/coc.nvim) for the last three years and decided to migrate to `Lua` and I am really happy with the improvement and control of each of your utilities.
I added and configured the plugins in the way that I have used them before, that is why this fork will remain independent.

The template that [Milton](https://github.com/miltonllera/neovim-config) left, which has given the main focus to Linux and Mac. I have expanded the guide for `Windows` since it is my development environment.

I have added some plugins recommended by the guys from [lunarVim](https://www.lunarvim.org/) and added some validations and plugins they use, achieving a very stable and agile version.

A [Neovim](https://github.com/neovim/neovim) configuration using Lua, with the minimal number of pluggins I need for programming.
Different language servers available through the LSP protocol provide code completion and analysis.

This readme exist so I don't have to remember how to do all these things when setting up a new machine.

## 🛠 Setting up

### Windows

![nvim Home](./img/home1.png)

Install [Chocolatey](https://chocolatey.org/install)

```bash
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

Install [Neovim](https://community.chocolatey.org/packages/neovim#install)

```bash
choco install neovim
```

Install [Git](https://community.chocolatey.org/packages/git)

```bash
choco install git
```

Install [Node](https://nodejs.org/en)

Global packages for npm (update your packages)

```bash
 npm install -g neovim
 npm install -g prettier
```

- Clone the repository inside off this folder or download the last [release](https://github.com/i-xarlos/neovim-config/releases/)

```bash
git clone https://github.com/i-xarlos/neovim-config.git ~/AppData/Local/nvim
```

- Neovim configuration file

```bash
~/AppData/Local/nvim
```

Install [Terminal](https://apps.microsoft.com/store/detail/windows-terminal/9N0DX20HK701?hl=en-us&gl=us)
You can download and install it from the microsoft store and choose your favorite font

Please review [nvim.tressitier](https://github.com/nvim-treesitter/nvim-treesitter/wiki/Windows-support) windows support

```bash
# Mingw toolchain
choco install mingw

# LLVM (Clang)
choco install llvm
```

Optionally:

- Handle packages from [Chocolatey Gui](https://community.chocolatey.org/packages/ChocolateyGUI)

```bash
 choco install chocolateygui
```

- Install NVM to handle node servers [https://community.chocolatey.org/packages/nvm]

```bash
# Install nvm
choco install nvm

# Nvm install node versions
nvm install 16.17.1
```

- NerdFonts https://www.nerdfonts.com/font-downloads

  - [Caskaydia Cove NF] (https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/CascadiaCode.zip) - my favorite
  - [Haslug] (https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/Hasklig.zip)
  - [Firacode] (https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/FiraCode.zip)

- Install [Ninja](https://github.com/ninja-build/ninja/wiki/Pre-built-Ninja-packages) using chocolate `choco install ninja`

  - Follow this [guide](https://github.com/sumneko/lua-language-server/wiki/Getting-Started) for install lua-language-server

  ```bash
   ~AppData\Local\nvim-data\lua-language-server
  ```

### Linux

The first step is to install the correct version of Neovim. Most plugins require version 0.5 or above, but `treesitter` actually requires >= 0.5.1. to work. Version 0.6 has now been relased, which means the previous comment is deprecated. Versions can be installed using `snap`:

```bash
# For stable versions
sudo snap install --beta nvim --classic

# For nightly versions
sudo snap install --edge nvim --classic
```

We also need to install the node package manager `npm` since most language servers are installed that way.

```bash
sudo apt install npm
```

### MacOS

Assume `brew` is installed, then installing Neovim is straighforward:

```bash
# For stable version
brew install neovim

# for nightly version
brew install --HEAD neovim

# To update
brew reinstall neovim
```

Additionally, you may need to configure the `Option` key to behave like `Alt`. In **iTerm2**, this can be done in `Preferences -> Profiles -> Keys`. Change the left option behaviour to `Esc+`. For **kitty**, you need to set `macos_option_as_alt left` (defualt is no) in the terminal's config file. Restarting the terminal (`Command + Q`, then restart) is required for this to take effect.

## ⭐ Installing the configuration

Clone the repo into Neovim's installation folder (usually `/home/<usr>/.config/nvim`):

```bash
git clone https://github.com/i-xarlos/neovim-config.git ~/.config/nvim
cd ~/.config/nvim
```

This will create a folder with the configuration with the following structure is as follows:

```
|- lua
|  |- config/
|       |- core/
|       |- defaults/
|       |- lazy/
|            |- init.lua
|       |- plugins/
\- init.lua
```

This structure is important since Lua will not load files that are not located inside `lua`. The file `init.lua` loads all the modules located inside this folder to set the configuration. Most of the names are self explanatory. The most important file here is `plugins.lua`, which is the module that loads the relevant plugins. Some of the most important plugins are:

1. [**`lazy`**](https://github.com/folke/lazy.nvim): Manage the plugins.
2. [**`lspconfig`**](https://github.com/neovim/nvim-lspconfig): provides a client for the different language servers using the Language Server Protocol (LSP).
3. [**`cmp`**](https://github.com/hrsh7th/nvim-cmp): Auto-complete functionality. Recommended by the core Neovim team.
4. [**`treesitter`**](https://github.com/nvim-treesitter/nvim-treesitter): Syntax highlighting and other functionality.
5. [**`NvimTree`**](https://github.com/kyazdani42/nvim-tree.lua): File explorer written in Lua.
6. [**`gitsigns`**](https://github.com/lewis6991/gitsigns.nvim): Git gutter highlighting and hunk management in buffer.
7. [**`telescope`**](https://github.com/nvim-telescope/telescope.nvim): Fuzzy finder.
8. [**`lualine`**](https://github.com/nvim-lualine/lualine.nvim): A status line written in Lua which is similar to `vim-airline`.

There are some more packages that are dependencies of the ones mentioned above, and some for formatting and theming as well. Adding new plugins is simple using the `use` function:

```lua
return{
  '<author>/<plugin-repo>',
   config = function() require('<plugin-name>').setup({}) end,
}
```

This will load a plugin with it's standard configuration. For more complex configurations, we create the relevant file in `lua/plugins` (eg. `lua/plugins/foo.lua`) and load it using the require function along with any other option we wish to pass on to the `use` function:

```lua
return {
  '<author>/<plugin-repo>',
  config = function() require('plugin/<plugin-name>') end,
  -- Optionally require other plugins.
  requires = '<author>/<required-plugin-repo>'
  -- Other functionality
}
```

Notice that the file type is omitted from this call.

Install and update plugins using packer

```bash
#nvim command
:Lazy
```

## 📋 Auto-completion

The auto-complete functionality is achieved by using `nvim-cmp` to attach the relevant language servers to the buffers containing code. Most servers only require that the on attach function is specified so that different motions are available. Currently, the common function to attach a server to a buffer is located in `lua/lsp/utils.lua` . It will enable common key mappings for all language servers to display code completion.

### Some further notes

Inline error messages are disabled in the current configuration. They create a lot of clutter. To enable them back, comment the code on line 34 of `lua/options.lua`. This is a `nvim` option related to it's `lsp` interface, not something provided by the servers themselves.

## Web-dev Icons

To visualize fancy icons and separators, a patched font must be installed. [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts) has many already patched and offers instructions on how to create new ones (I don't recommend). To install a patched font follow these instructions:

1. Head to the [repo](https://github.com/ryanoasis/nerd-fonts) and download the font. I use Robot Mono.
2. Copy the file to the relevant folder:

- Linux: `~/.local/share/fonts/`.
- MacOS: `/Library/Fonts'`.

3. Change the font in the terminal emulator's settings to the patched font.

Yaml issues:
Please verify: https://github.com/nvim-treesitter/nvim-treesitter/issues/3587

### Nerd Fonts with Kitty

If using `kitty` as default terminal, then the procedure above won't work. First, `kitty` does not support non-monospaced fonts due to how it renders text. Second, the fonts cannot be patched. In fact, kitty takes care of patching on it's own which is great. To install the fonts follow the instructions in this [blog](https://erwin.co/kitty-and-nerd-fonts/#symbols), which are straighforward.

TL;DR for `MacOS`:

1. Download and install the fonts and put the file `Symbols-2048-em Nerd Font Complete.tff` (or whatever subset you decide to use) in the `Library/Fonts/` folder for system wide use, or the local variant.
2. If the glyphs aren't displayed by default, then they can be specified manually by following the instructions.
3. Refresh the fonts cache.

## 📗 Shortcuts:

If you need more information you can find more shortcuts in `options.lua` and `keymaps.lua`:

```
|- lua
|  |- core/
|  |  | - options.lua
|  |  | - keymaps.lua
```

### Some of the most used shortcuts:

Vim is very complete and extensive in its utilities, here I put the ones that I use most commonly and have been customized in this configuration.

| Keys         | Description                                         |
| ------------ | --------------------------------------------------- |
| [Leader]     | Space                                               |
| [Leader-e]   | Open NvimTree (Toggle)                              |
| [Leader-f-f] | Telescope find in files                             |
| [Leader-f-b] | Telescope find in buffers                           |
| [Leader-f-g] | Telescope find text (live grep)                     |
| [Leader-g-i] | Lua go to implemetation (live grep)                 |
| [Leader-g-r] | Telescope go to reference (live grep)               |
| [Leader-f]   | Quick lsp format                                    |
| [Leader-cc]  | Comment code block (visual selected text)           |
| [Leader-cu]  | Uncomment code block (visual selected text)         |
| [TAB]        | Select autocomplete element / Change Buffer (Right) |
| [S-TAB]      | Select autocomplete element / Change Buffer (Left)  |
| [C-n]        | Highlighting word                                   |
| [K]          | Show documentation / Close autocomplete             |
| [k-j]        | Escape                                              |
| [C-c]        | Close Buffer                                        |
| [C-s]        | Save document                                       |
| [g-g]        | Move cursor to document top                         |
| [G-G]        | Move cursor to document bottom                      |
| [A-h]        | Jump to left (Buffer)                               |
| [A-j]        | Jump to bottom (Buffer)                             |
| [A-k]        | Jump to top (Buffer)                                |
| [A-l]        | Jump to right (Buffer)                              |

## Commands:

| Command | Description      |
| ------- | ---------------- |
| :vs     | vertical split   |
| :split  | horizontal split |

Some pluggins to try:

- Ranger integration: [Rnvimr](https://github.com/kevinhwang91/rnvimr). Use ranger in a floating buffer instead of as a tiled buffer.
- Different file explorer: [ranger.vim](https://github.com/francoiscabrol/ranger.vim) which can be used to integrate the [Ranger](https://github.com/ranger/ranger) terminal file explorer into Vim.
- Using GBrowse with fugitive: [rhubarb.vim](https://github.com/tpope/rhubarb.vim).
- Prettier quickfix/localist: [trouble.nvim](https://github.com/folke/trouble.nvim).
- Jupyter on Neovim: [jupytext.vim](https://github.com/mwouts/jupytext), [iron.nvim](https://github.com/hkupty/iron.nvim), [vim-textobj-hydrogen](https://github.com/GCBallesteros/vim-textobj-hydrogen). Check this [blog](https://www.maxwellrules.com/misc/nvim_jupyter.html) for more info.

## Attributions

The structre of this config was based on [yashguptaz](https://github.com/yashguptaz/)'s [config](https://github.com/yashguptaz/nvy) and tutorial which helped me understand the basics of using Lua with Neovim.

I've also stolen code from different sources which means it might be hard to acknowledge all of them explicitly though most of them are from the associated plugin's documentation.
