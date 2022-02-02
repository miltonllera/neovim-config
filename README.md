# Neovim configuration with Lua

A [Neovim](https://github.com/neovim/neovim) configuration using Lua, with the minimal number of pluggins I need for programming. Different language servers available through the LSP protocol provide code completion and analysis.

This readme exist so I don't have to remember how to do all these things when setting up a new machine.

## Setting up

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

## Installing the configuration

Clone the repo into Neovim's installation folder (usually `/home/<usr>/.config/nvim`):
```bash
git clone https://github.com/miltonllera/neovim-lua-config ~/.config/nvim
cd ~/.config/nvim
```

This will create a folder with the configuration with the following structure is as follows:
```
|- lua
|  |- lsp/
|  |- plugins/
|  |- keymaps.lua
|  |- options.lua
|  |- plugins.lua
|  |- theme.lua
|  \- utils.lua
|- plugin/
\- init.lua
```

This structure is important since Lua will not load files that are not located inside `lua`. The file `init.lua` loads all the modules located inside this folder to set the configuration. Most of the names are self explanatory. The most important file here is `plugins.lua`, which is the module that loads the relevant plugins. Some of the most important plugins are:

1. [**`packer`**](https://github.com/wbthomason/packer.nvim): Manage the plugins.
2. [**`lspconfig`**](https://github.com/neovim/nvim-lspconfig): provides a client for the different language servers using the Language Server Protocol (LSP).
3. [**`cmp`**](https://github.com/hrsh7th/nvim-cmp): Auto-complete functionality. Recommended by the core Neovim team.
4. [**`treesitter`**](https://github.com/nvim-treesitter/nvim-treesitter): Syntax highlighting and other functionality.
5. [**`NvimTree`**](https://github.com/kyazdani42/nvim-tree.lua): File explorer written in Lua.
6. [**`fugitive`**](https://github.com/tpope/vim-fugitive): The best plugin for git.
7. [**`gitsigns`**](https://github.com/lewis6991/gitsigns.nvim): Git gutter highlighting and hunk management in buffer.
8. [**`telescope`**](https://github.com/nvim-telescope/telescope.nvim): Fuzzy finder.
9. [**`lualine`**](https://github.com/nvim-lualine/lualine.nvim): A status line written in Lua which is similar to `vim-airline`.

There are some more packages that are dependencies of the ones mentioned above, and some for formatting and theming as well. Adding new plugins is simple using the `use` function:

```lua
use({
  '<author>/<plugin-repo>',
  config = function() require('<plugin-name>').setup({}) end,
})
```

This will load a plugin with it's standard configuration. For more complex configurations, we create the relevant file in `lua/plugins` (eg. `lua/plugins/foo.lua`) and load it using the require function along with any other option we wish to pass on to the `use` function:

```lua
use({
  '<author>/<plugin-repo>',
  config = function() require('plugin/<plugin-name>') end,
  -- Optionally require other plugins.
  requires = '<author>/<required-plugin-repo>'
  -- Other functionality
})
```

Notice that the file type is omitted from this call.

## Auto-completion

The auto-complete functionality is achieved by using `nvim-cmp` to attach the relevant language servers to the buffers containing code. Most servers only require that the on attach function is specified so that different motions are available. Currently, the common function to attach a server to a buffer is located in `lua/lsp/utils.lua` . It will enable common key mappings for all language servers to display code completion.

The second part is installing the language servers themselves (described below) and enabling them. `:LspInstall` can be used if [`nvim-lsp-installer`](https://github.com/williamboman/nvim-lsp-installer/) is found. Others may require manual installation. There is an extra step which involves installing the binaries for these servers, which we describe below.

### Installing the language servers

Binaries for each language servers must be installed from their relevant repo. Most servers are installed using `npm install`, but others like `clangd` and `sumneko` for Lua require more involved procedures. Here is a list of servers and installation methods:

- **Bash**: bashls

  ```bash
  npm i -g bash-language-server
  ```

- **C/C++**: clangd
  May have to try several versions, but 13 is the latest one. I am using 12 and 9 or 8 should be available.

  ```bash
  sudo apt-get install clangd-13
  ```
  Then we must make it the default clangd (example with clangd-13):
  ```bash
  sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-13 100
  ```

- **Docker**: dockerls

  ```bash
  npm i -g dockerfile-language-server-nodejs
  ```

- **Julia**: julials

  ```bash
  julia --project=~/.julia/environments/nvim-lspconfig -e 'using Pkg; Pkg.add("LanguageServer")'
  ```

- **Json**: jsonls

  ```bash
  npm i -g vscode-langservers-extracted
  ```

- **Lua**: sumneko_lua
  This one is a tricky one as you have to manually clone the repo and then compile it. I did not have any issues, but I did have to install ninja for this, which can be done through `apt install ninja-build`.

  1. First clone:
  ```bash
  git clone https://github.com/sumneko/lua-language-server
  cd lua-language-server
  git submodule update --init --recursive
  ```
  2. Next we manually build the server binaries:
  ```bash
  cd 3rd/luamake
  ./compile/install.sh
  cd ../..
  ./3rd/luamake/luamake rebuild
  ```
  The configuration file in the `lsp` folder for this server should reference these binaries and the root folder of the code. I've set it to `~/.local/share/nvim/site/lsp\_servers/sumneko` there is `sumneko_lua` there which is the Lua module used to hook into this one, be careful no to overwrite.

- **Python**: pyright:

  ```bash
  npm i -g pyright
  ```

- **YAML**: yamlls

  This install requires `yarn` to work

  ```bash
  yarn global add yaml-language-server
  ```

If a module complains about the verion of node being too old (pyright will do this), then run the following:
```bash
sudo npm cache clean -f
sudo npm install -g n
sudo n stable
```
Make sure to use the `-g` on all `npm` installs, otherwise the server won't be found.

### Some further notes

Inline error messages are disabled in the current configuration. They create a lot of clutter. To enable them back, comment the code on line 34 of `lua/options.lua`. This is a `nvim` option related to it's `lsp` interface, not something provided by the servers themselves.

## Web-dev Icons

To visualize fancy icons and separators, a patched font must be installed. [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts) has many already patched and offers instructions on how to create new ones (I don't recommend). To install a patched font follow these instructions:
1. Head to the [repo](https://github.com/ryanoasis/nerd-fonts) and download the font. I use Robot Mono.
2. Copy the file to `~/.local/share/fonts/`
3. Change the font in the terminal emulator's settings to the patched font.

## TODO:

Improvements:
- Only open diagnostics if there are any to show.
- Toggle highlighting on and off.

LSPs to add:
- LaTex: can use [ltext](https://github.com/valentinjn/ltex-ls) or [texlab](https://github.com/latex-lsp/texlab).
- Markdownd: [ltext](https://github.com/valentinjn/ltex-ls) or [zeta\_note](https://github.com/artempyanykh/zeta-note).

Some pluggins to try:
- Ranger integration: [Rnvimr](https://github.com/kevinhwang91/rnvimr). Use ranger in a floating buffer instead of as a tiled buffer.
- Markdown preview: [glow.nvim](https://github.com/ellisonleao/glow.nvim).
- Different file explorer: [ranger.vim](https://github.com/francoiscabrol/ranger.vim) which can be used to integrate the [Ranger](https://github.com/ranger/ranger) terminal file explorer into Vim.
- Using GBrowse with fugitive: [rhubarb.vim](https://github.com/tpope/rhubarb.vim).
- Prettier quickfix/localist: [trouble.nvim](https://github.com/folke/trouble.nvim).
- Jupyter on Neovim: [jupytext.vim](https://github.com/mwouts/jupytext), [iron.nvim](https://github.com/hkupty/iron.nvim), [vim-textobj-hydrogen](https://github.com/GCBallesteros/vim-textobj-hydrogen). Check this [blog](https://www.maxwellrules.com/misc/nvim_jupyter.html) for more info.


## Attributions

The structre of this config was based on [yashguptaz](https://github.com/yashguptaz/)'s [config](https://github.com/yashguptaz/nvy) and tutorial which helped me understand the basics of using Lua with Neovim.

I've also stolen code from different sources which means it might be hard to acknowledge all of them explicitly though most of them are from the associated plugin's documentation.
