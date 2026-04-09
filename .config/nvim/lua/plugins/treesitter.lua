-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
local setup_treesitter = function()
    -- Jai grammar from: https://github.com/constantitus/tree-sitter-jai
    local jai_grammar_path = vim.fn.expand("~/Projects/tree-sitter-jai")
    if vim.fn.isdirectory(jai_grammar_path) == 1 then
        vim.api.nvim_create_autocmd('User', {
            pattern = 'TSUpdate',
            callback = function()
                require('nvim-treesitter.parsers').jai = {
                    install_info = {
                        path = jai_grammar_path,
                        queries = 'queries/jai',
                    },
                }
            end,
        })
        vim.opt.runtimepath:append(jai_grammar_path)
        vim.filetype.add({ extension = { jai = "jai" } })
    end

    -- Install desired parsers (replaces old ensure_installed)
    local ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'vimdoc', 'vim', 'dockerfile' }
    local installed = require('nvim-treesitter.config').get_installed()
    local to_install = vim.tbl_filter(function(lang)
        return not vim.list_contains(installed, lang)
    end, ensure_installed)
    if #to_install > 0 then
        require('nvim-treesitter.install').install(to_install)
    end

    -- Textobjects: select
    local select_textobject = function(query)
        return function()
            require('nvim-treesitter-textobjects.select').select_textobject(query, 'textobjects')
        end
    end
    vim.keymap.set({ 'x', 'o' }, 'aa', select_textobject('@parameter.outer'))
    vim.keymap.set({ 'x', 'o' }, 'ia', select_textobject('@parameter.inner'))
    vim.keymap.set({ 'x', 'o' }, 'af', select_textobject('@function.outer'))
    vim.keymap.set({ 'x', 'o' }, 'if', select_textobject('@function.inner'))
    vim.keymap.set({ 'x', 'o' }, 'ac', select_textobject('@class.outer'))
    vim.keymap.set({ 'x', 'o' }, 'ic', select_textobject('@class.inner'))

    -- Textobjects: move
    local move = require('nvim-treesitter-textobjects.move')
    vim.keymap.set({ 'n', 'x', 'o' }, ']f', function() move.goto_next_start('@function.outer', 'textobjects') end)
    vim.keymap.set({ 'n', 'x', 'o' }, ']]', function() move.goto_next_start('@class.outer', 'textobjects') end)
    vim.keymap.set({ 'n', 'x', 'o' }, ']F', function() move.goto_next_end('@function.outer', 'textobjects') end)
    vim.keymap.set({ 'n', 'x', 'o' }, '][', function() move.goto_next_end('@class.outer', 'textobjects') end)
    vim.keymap.set({ 'n', 'x', 'o' }, '[f', function() move.goto_previous_start('@function.outer', 'textobjects') end)
    vim.keymap.set({ 'n', 'x', 'o' }, '[[', function() move.goto_previous_start('@class.outer', 'textobjects') end)
    vim.keymap.set({ 'n', 'x', 'o' }, '[F', function() move.goto_previous_end('@function.outer', 'textobjects') end)
    vim.keymap.set({ 'n', 'x', 'o' }, '[]', function() move.goto_previous_end('@class.outer', 'textobjects') end)

    -- Textobjects: swap
    vim.keymap.set('n', '<leader>sa', function()
        require('nvim-treesitter-textobjects.swap').swap_next('@parameter.inner')
    end)
    vim.keymap.set('n', '<leader>sA', function()
        require('nvim-treesitter-textobjects.swap').swap_previous('@parameter.inner')
    end)

    -- Textobjects config (lookahead, set_jumps)
    require('nvim-treesitter-textobjects').setup {
        select = { lookahead = true },
        move = { set_jumps = true },
    }
end

return {
    -- Highlight, edit, and navigate code
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ':TSUpdate',
        config = function()
            setup_treesitter()
        end
    },
    -- Sticky context text
    {
        'nvim-treesitter/nvim-treesitter-context',
        opts = {
            enabled = true,
            separator = '=',
        },
    },
}
