return {
  -- Rust syntax support
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },

  -- Shows crate versions, updates, and docs inline in Cargo.toml
  {
    "saecki/crates.nvim",
    tag = "stable",
    ft = { "toml" },
    config = function()
      require("crates").setup({
        completion = {
          cmd = {
            enable = true,
          },
        },
      })
    end,
  },
  { "arzg/vim-rust-syntax-ext" },

  -- Debugging
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  },

  -- UI debugging
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      require("dapui").setup()
    end,
  },

  -- Alternative Rust LSP (rustaceanvim)
  {
    "mrcjkb/rustaceanvim",
    version = "^6", -- recommended
    lazy = false,
    config = function()
      local manson_register = require("mason-registry")
      local codelldb = manson_register.get_package("codelldb")
      local extension_path = codelldb:get_install_path() .. "/extension/"
      local codelldb_path = extension_path .. "adapter/codelldb"
      local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
      local cfg = require("rustaceanvim.config")

      vim.g.rustaceanvim = {
        dap = {
          adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
        },
        server = {
          settings = {
            ["rust-analyzer"] = {
              diagnostics = { enable = false },
            },
          },
        },
      }
    end,
  },
}
