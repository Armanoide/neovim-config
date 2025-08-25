local map = vim.keymap.set

-- Resize window
map("n", "<C-Down>", "<C-w>-")
map("n", "<C-Up>", "<C-w>+")
map("n", "<C-Left>", "<C-w><")
map("n", "<C-Right>", "<C-w><")
-- Move between windows with Cmd + hjkl (Mac)
map("n", "<D-h>", "<C-w>h", { noremap = true, silent = true })
map("n", "<D-j>", "<C-w>j", { noremap = true, silent = true })
map("n", "<D-k>", "<C-w>k", { noremap = true, silent = true })
map("n", "<D-l>", "<C-w>l", { noremap = true, silent = true })

-- Save file with Cmd+S (Mac)
vim.api.nvim_set_keymap("n", "<D-s>", ":w<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<D-s>", "<Esc>:w<CR>", { noremap = true, silent = true })

-- Open terminal in a horizontal split below
-- map("n", "<leader>wt", function()
--   vim.cmd("belowright split | terminal")
-- end, { desc = "Terminal Below" })
vim.keymap.set("n", "<leader>wt", function()
  -- Open terminal in a split, starting in current cwd
  local file_dir = vim.fn.expand("%:p:h")
  if file_dir == "" then
    file_dir = vim.loop.cwd() -- fallback if no file is open
  end

  vim.cmd("belowright split")
  vim.cmd("lcd " .. file_dir) -- make the split's cwd the global cwd
  vim.cmd("terminal")
  vim.cmd("startinsert")
end, { desc = "Open Terminal in cwd" })
map("t", "<C-z>", "<C-\\><C-n>", { desc = "Terminal Normal Mode" })
-- Nvim DAP
map("n", "<Leader>dl", "<cmd>lua require'dap'.step_into()<CR>", { desc = "Debugger step into" })
map("n", "<Leader>dj", "<cmd>lua require'dap'.step_over()<CR>", { desc = "Debugger step over" })
map("n", "<Leader>dk", "<cmd>lua require'dap'.step_out()<CR>", { desc = "Debugger step out" })
map("n", "<Leader>dc", "<cmd>lua require'dap'.continue()<CR>", { desc = "Debugger continue" })
map("n", "<Leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", { desc = "Debugger toggle breakpoint" })
map(
  "n",
  "<Leader>dd",
  "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
  { desc = "Debugger set conditional breakpoint" }
)
map("n", "<Leader>de", "<cmd>lua require'dap'.terminate()<CR>", { desc = "Debugger reset" })
map("n", "<Leader>dr", "<cmd>lua require'dap'.run_last()<CR>", { desc = "Debugger run last" })

-- rustaceanvim
map("n", "<Leader>dt", "<cmd>lua vim.cmd('RustLsp testables')<CR>", { desc = "Debugger testables" })
