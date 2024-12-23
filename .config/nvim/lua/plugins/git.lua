-- Git related plugins
return {
    'tpope/vim-fugitive',
    'tpope/vim-rhubarb',
    {
        -- Adds git releated signs to the gutter, as well as utilities for managing changes
        'lewis6991/gitsigns.nvim',
        opts = {
            -- See `:help gitsigns.txt`
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
            current_line_blame_opts = {
                delay = 100,
            },
        },
        config = function()
            require('gitsigns').setup()

            vim.keymap.set('n', '[g', require('gitsigns').prev_hunk, { buffer = bufnr, desc = 'Previous [G]it Hunk' })
            vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk,
                { buffer = bufnr, desc = '[G]it Hunk [P]revious' })
            vim.keymap.set('n', ']g', require('gitsigns').next_hunk, { buffer = bufnr, desc = 'Next [G]it Hunk' })
            vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk,
                { buffer = bufnr, desc = '[G]it Hunk [N]ext' })
            vim.keymap.set('n', '<leader>gh', require('gitsigns').preview_hunk,
                { buffer = bufnr, desc = 'Previw [G]it [H]unk' })
            vim.keymap.set('n', '<leader>gb', require('gitsigns').toggle_current_line_blame,
                { buffer = bufnr, desc = 'Toggle [G]it Line [B]lame' })
            vim.keymap.set('n', '<leader>gu', require('gitsigns').reset_hunk,
                { buffer = bufnr, desc = 'Toggle [G]it [U]ndo (Reset) Hunk' })
            vim.keymap.set('n', '<leader>gs', require('gitsigns').stage_hunk,
                { buffer = bufnr, desc = 'Toggle [G]it [S]tage Hunk' })
            vim.keymap.set('n', '<leader>gr', require('gitsigns').undo_stage_hunk,
                { buffer = bufnr, desc = 'Toggle [G]it [R]eset (Undo previous) Hunk' })
        end
    },
    {
        'sindrets/diffview.nvim',
        config = function()
            vim.keymap.set('n', '<leader>gd', '<Cmd>DiffviewOpen<CR>', { desc = '[G]it [D]iff' })
            vim.keymap.set('n', '<leader>gq', '<Cmd>DiffviewClose<CR>', { desc = '[G]it Diff [Q]uit' })
            vim.keymap.set('n', '<leader>gc', function()
                vim.cmd('DiffviewClose')
                vim.cmd('Git commit')
                vim.cmd('startinsert')
            end, { desc = '[G]it [C]ommit' })
        end
    }
}
