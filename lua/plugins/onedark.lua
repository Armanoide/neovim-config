return {
  "navarasu/onedark.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("onedark").setup {
      style = "dark",
      transparent = true,
      term_colors = true,
      ending_tildes = true,
      cmp_itemkind_reverse = true,
    }
    require("onedark").load()
  end,
}
