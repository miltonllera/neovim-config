return {
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      -- Configuración base del plugin
      local comment = require("Comment")
      
      -- Integración con ts_context_commentstring para mejor soporte de lenguajes anidados
      comment.setup({
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
        
        -- Opciones de rendimiento
        ignore = '^$', -- Ignorar líneas vacías
        sticky = true,  -- Mantener cursor en la misma posición
        
        -- Configuración de keymappings
        -- gcc: Comentar línea actual
        -- gbc: Comentar bloque actual
        -- gc[motion]: Comentar motion
        -- gb[motion]: Comentar bloque motion
        
        -- Optimizaciones para archivos grandes
        throttle = true, -- Limitar actualizaciones frecuentes
      })
        -- Verificar si el archivo es grande para desactivar funcionalidades
      vim.api.nvim_create_autocmd("BufReadPost", {
        callback = function(ev)
          local max_filesize = 500 * 1024 -- 500 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(ev.buf))
          
          if ok and stats and stats.size > max_filesize then
            -- Desactivar algunas funcionalidades avanzadas para archivos grandes
            vim.b[ev.buf].ts_context_commentstring_disabled = true
            -- Mantener el spell checking activo incluso para archivos grandes
            vim.opt_local.spell = true
          end
        end
      })
      
      -- Toggle de documentación con Shift+K
      vim.keymap.set('n', 'K', function()
        -- Buscar ventana flotante de ayuda
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local config = vim.api.nvim_win_get_config(win)
          if config.relative ~= '' then
            local buf = vim.api.nvim_win_get_buf(win)
            local ft = vim.api.nvim_buf_get_option(buf, 'filetype')
            if ft == 'help' or ft == 'markdown' then
              vim.api.nvim_win_close(win, true)
              return -- Evita que se ejecute la acción por defecto
            end
          end
        end
        vim.lsp.buf.hover()
      end, { desc = 'Toggle documentación flotante LSP' })
    end,
  },
}
