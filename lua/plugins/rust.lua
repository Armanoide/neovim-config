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
    ft = "rust",
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
          on_attach = function(client, bufnr)
            local lsp_map = function(mode, keys, func, desc)
              vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
            end
            -- rust-lsp mappings
            lsp_map("n", "K", function()
              vim.cmd.RustLsp { "hover", "actions" }
            end, "Rust hover docs")
            lsp_map("n", "J", function()
              vim.cmd.RustLsp "joinLines"
            end, "Rust join lines")
            lsp_map("n", "<Leader>cw", "<Nop>", "Rust Commands")
            lsp_map("n", "<Leader>cwa", function()
              vim.cmd.RustLsp "codeAction"
            end, "Rust Code action")
            lsp_map("n", "<Leader>cwe", function()
              vim.cmd.RustLsp "explainError"
            end, "Rust error explain")
            lsp_map("n", "<Leader>cwd", function()
              vim.cmd.RustLsp "openDocs"
            end, "Rust docs")
            lsp_map("n", "<Leader>cwm", function()
              vim.cmd.RustLsp "expandMacro"
            end, "Rust expand macro")

            -- copy from lsp_config
            lsp_map("n", "gd", vim.lsp.buf.definition, "Goto definition")
            lsp_map("n", "gD", vim.lsp.buf.declaration, "Goto declaration")
            lsp_map("n", "gI", vim.lsp.buf.implementation, "Goto implementation")
            lsp_map("n", "go", vim.lsp.buf.type_definition, "Goto type definition")
            lsp_map("n", "gr", vim.lsp.buf.references, "Goto references")
            lsp_map("n", "ra", vim.lsp.buf.rename, "Rename")
          end,
          settings = {
            cargo = {
              allFeatures = true,
            },
            ["rust-analyzer"] = {
              diagnostics = { enable = true },
            },
          },
        },
      }
    end,
  },
}
