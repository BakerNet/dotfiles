-- [[ Highlight on yank ]]
-- See `:help vim.hl.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    if vim.hl ~= nil then
      vim.hl.on_yank()
    else
      -- Remove after neovim 0.11 (deprecated)
      vim.highlight.on_yank()
    end
  end,
  group = highlight_group,
  pattern = '*',
})
