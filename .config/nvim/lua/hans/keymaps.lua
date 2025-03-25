-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Yanked from Primeagen ]]
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
-- [[ End Yanked from Primeagen]]

-- Use quick window changes
vim.keymap.set('n', '<C-h>', [[<Cmd>wincmd h<CR>]])
vim.keymap.set('n', '<C-j>', [[<Cmd>wincmd j<CR>]])
vim.keymap.set('n', '<C-k>', [[<Cmd>wincmd k<CR>]])
vim.keymap.set('n', '<C-l>', [[<Cmd>wincmd l<CR>]])
vim.keymap.set('n', '<leader>rl', [[<Cmd>vertical resize -10<CR>]])
vim.keymap.set('n', '<leader>rh', [[<Cmd>vertical resize +10<CR>]])
vim.keymap.set('n', '<leader>rj', [[<Cmd>resize -10<CR>]])
vim.keymap.set('n', '<leader>rk', [[<Cmd>resize +10<CR>]])

-- buffers
vim.keymap.set('n', '<leader>bp', [[<Cmd>bprev<CR>]])
vim.keymap.set('n', '<leader>bn', [[<Cmd>bnext<CR>]])

-- save with C-s
vim.keymap.set({ 'n', 'i' }, '<C-s>', [[<Cmd>wa!<CR>]])

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>df', vim.diagnostic.open_float, { desc = 'Open [D]iagnostic [F]loating message' })
vim.keymap.set("n", "<leader>dv", require("hans.diagnostics").line_diagnostics,
  { buffer = bufnr, desc = 'Open [D]iagnostic Source ([v]erbose) Floating message' })
vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, { desc = 'Open [D]iagnostics [L]ist' })
