
require'lspconfig'.julia_ls.setup{
    cmd = { "julia", "--startup-file=no", "--history-file=no",
            "-e", [[
                import LanguageServer; import Pkg;
                Pkg.activate();
                server = LanguageServer.LanguageServerInstance(stdin, stdout, false);
                server.runlinter = true;
                server.run()
            ]]
    };
    filetypes = { "julia" };
}

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "julia" },  -- Install Julia parser
  highlight = { enable = true },
}
