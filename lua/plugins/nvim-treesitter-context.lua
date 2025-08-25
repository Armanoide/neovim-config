return {
  "nvim-treesitter/nvim-treesitter-context",
  config = function(_, opts)
    require("treesitter-context").setup(opts)
  end
}
