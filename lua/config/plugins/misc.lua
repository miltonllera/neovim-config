return {
  {
    'eandrju/cellular-automaton.nvim',
    config = function()
      local ca = require('cellular-automaton')
      local animations = {'make_it_rain', 'game_of_life', 'scramble'}
      local rand_anim = function()
        ca.start_animation(animations[math.random(#animations)])
      end
      vim.keymap.set("n", "<leader>fml", rand_anim)
    end,
  }
}
