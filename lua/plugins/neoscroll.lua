return {
  "karb94/neoscroll.nvim",
  config = function()
    local neoscroll = require("neoscroll")
    local keymap = {
      ["<D-Up>"] = function() neoscroll.ctrl_b({ duration = 450 }) end,
      ["<D-Down>"] = function() neoscroll.ctrl_f({ duration = 450 }) end,
      ["<D-f>"] = function() neoscroll.ctrl_u({ duration = 450, easing = 'sine' }) end,
      ["<D-b>"] = function() neoscroll.ctrl_d({ duration = 450, easing = 'sine' }) end,
    }

    local modes = { "n", "i", "v", "c" }
    for key, func in pairs(keymap) do
      vim.keymap.set(modes, key, func, { silent = true, desc = "Neoscroll: " .. key })
    end
  end
}
