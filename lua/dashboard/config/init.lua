return {
  { "folke/snacks.nvim", opts = { dashboard = { enabled = false } } },
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    enabled = true,
    init = false,
    priority = 1000,
    dependencies = { "nvim-tree/nvim-web-devicons", "folke/snacks.nvim" },
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      local header = require("dashboard.utils.dan_dan_dan")

      -- Header
      dashboard.section.header.val = header.val
      dashboard.section.header.opts.hl = header.opts.hl
      header.load_hl()

      -- Buttons
      -- stylua: ignore
      dashboard.section.buttons.val = {
        dashboard.button("r", " " .. " Recent files", [[<cmd> lua LazyVim.pick("oldfiles")() <cr>]]),
        dashboard.button("g", " " .. " Find text", [[<cmd> lua LazyVim.pick("live_grep")() <cr>]]),
        dashboard.button("c", " " .. " Config", "<cmd> lua LazyVim.pick.config_files()() <cr>"),
        dashboard.button("x", " " .. " Lazy Extras", "<cmd> LazyExtras <cr>"),
        dashboard.button("l", "󰒲 " .. " Lazy", "<cmd> Lazy <cr>"),
        dashboard.button("q", " " .. " Quit", "<cmd> qa <cr>"),
      }
      -- Define colors
      vim.api.nvim_set_hl(0, "AlphaButtons", { fg = "#6a1b13", bold = true })
      vim.api.nvim_set_hl(0, "AlphaShortcut", { fg = "#46806e", bold = true })
      vim.api.nvim_set_hl(0, "AlphaFooter", { fg = "#dbdfe6", italic = true })

      -- Apply highlights
      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = "AlphaButtons"
        button.opts.hl_shortcut = "AlphaShortcut"
      end

      dashboard.section.buttons.opts.hl = "AlphaButtons"
      dashboard.section.footer.opts.hl = "AlphaFooter"
      return dashboard
    end,
    config = function(_, dashboard)
      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          once = true,
          pattern = "AlphaReady",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      require("alpha").setup(dashboard.opts)

      vim.api.nvim_create_autocmd("User", {
        once = true,
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = "⚡ Neovim loaded "
              .. stats.loaded
              .. "/"
              .. stats.count
              .. " plugins in "
              .. ms
              .. "ms"
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  }
}
