require("copilot").setup({
    panel = {
      auto_refresh = false,
      keymap = {
        accept = "<CR>",
        jump_prev = "[[",
        jump_next = "]]",
        refresh = "gr",
        open = "<M-CR>",
      },
    },
    suggestion = {
      auto_trigger = false,
      keymap = {
        accept = false,
        accept_word = "<M-Right>",
        accept_line = "<M-Down>",
        prev = "<M-[>",
        next = "<M-]>",
        dismiss = "<C-]>",
      },
    },
  })

  local suggestion = require("copilot.suggestion")

  vim.keymap.set("i", "<M-SPACE>", function()
    if suggestion.is_visible() then
      suggestion.accept()
    else
      suggestion.next()
    end
  end, { desc ="[copilot] accept or next suggestion" })
