return {
  { "folke/tokyonight.nvim", enabled = false },
  { "catppuccin/nvim",       enabled = false },
  {
    "akinsho/bufferline.nvim",
    enabled = false,
    config = function()
      vim.o.showtabline = 0
    end,
  },
  {
    "folke/flash.nvim",
    enabled = false,
  },
  { "stevearc/conform.nvim", enabled = false },
}
