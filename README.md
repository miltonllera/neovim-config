# Neovim configuration with Lua

A Neovim setup that (mainly) uses Lua to setup pluggins and configurations in an organized and readable manner.

## Autocompletion

### Setting up language servers

Language servers must be installed from their relevant repo. Most servers are installed using `npm install`, but others like clangd and sumneko for Lua require more involved procedures. Here is a list of servers and installation methods:

- Bash: bashls
  ```
  npm i -g bash-language-server
  ```
- C/C++: clangd
  May have to try several versions, but 13 is the latest one. I am using 12 and 9 or 8 should be available.
  ```
  sudo apt-get install clangd-13
  ```
  Then we must make it the default clangd (example with clangd-13):
  ```
  sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-13 100
  ```
- Docker: dockerls
  ```
  npm i -g dockerfile-language-server-nodejs
  ```
- Julia: julials
  ```
  julia --project=~/.julia/environments/nvim-lspconfig -e 'using Pkg; Pkg.add("LanguageServer")'
  ```
- Json: jsonls
  ```
  npm i -g vscode-langservers-extracted
  ```
- Lua: sumneko_lua
  This one is a tricky one as you have to manually clone the repo and then compile it. I did not have any issues, but I did have to install ninja for this, which can be done through `apt install ninja-build`.
  1. First clone:
  ```
  git clone https://github.com/sumneko/lua-language-server
  cd lua-language-server
  git submodule update --init --recursive
  ```
  2. Next we manually build the server binaries:
  ```
  cd 3rd/luamake
  ./compile/install.sh
  cd ../..
  ./3rd/luamake/luamake rebuild
  ```
  The configuration file in the `lsp` folder for this server should reference these binaries and the root folder of the code. I've set it to `~/.local/share/nvim/site/lsp_servers/sumneko` there is `sumneko_lua` there which is the Lua module used to hook into this one, be careful no to overwrite.
- Python: pyright: 
  ```
  npm i -g pyright
  ```
- YAML: yamlls
  TODO


If a module complains about the verion of node being too old (pyright will do this), then run the following:
```
sudo npm cache clean -f
sudo npm install -g n
sudo n stable
```
Make sure to use the `-g` on all `npm` installs, otherwise the server won't be found.
