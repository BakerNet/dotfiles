return {
    -- Giving Github copilot a try
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                suggestion = {
                    auto_trigger = true,
                    keymap = {
                        accept = "<M-y>",
                        next = "<M-n>",
                        prev = "<M-p>",
                        dismiss = "<M-e>",
                    },
                }
            })
            vim.keymap.set('n', '<leader>tc', function()
                    require("copilot.suggestion").toggle_auto_trigger()
                    print('Copilot auto trigger: ' .. (vim.b.copilot_suggestion_auto_trigger and "on" or "off"))
                end,
                { desc = "[T]oggle [C]opilot" })

            vim.api.nvim_create_autocmd('User', {
                pattern = 'BlinkCmpListSelect',
                callback = function()
                    if require('blink.cmp.completion.list').get_selected_item() ~= nil then
                        require("copilot.suggestion").dismiss()
                        vim.b.copilot_suggestion_hidden = true
                    end
                end,
            })

            vim.api.nvim_create_autocmd('User', {
                pattern = 'BlinkCmpCompletionMenuClose',
                callback = function()
                    vim.b.copilot_suggestion_hidden = false
                end,
            })
        end,
    },
    -- Claude Code
    {
        "greggh/claude-code.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim", -- Required for git operations
        },
        config = function()
            require("claude-code").setup({
                window = {
                    position = "float",
                    float = {
                        width = "90%",     -- Take up 90% of the editor width
                        height = "90%",    -- Take up 90% of the editor height
                        row = "center",    -- Center vertically
                        col = "center",    -- Center horizontally
                        relative = "editor",
                        border = "double", -- Use double border style
                    },
                },
                keymaps = {
                    toggle = {
                        normal = "<leader>cc",       -- Normal mode keymap for toggling Claude Code, false to disable
                        terminal = "<M-c>",          -- Terminal mode keymap for toggling Claude Code, false to disable
                        variants = {
                            continue = "<leader>cC", -- Normal mode keymap for Claude Code with continue flag
                            verbose = "<leader>cV",  -- Normal mode keymap for Claude Code with verbose flag
                        },
                    },
                    window_navigation = false, -- Enable window navigation keymaps (<C-h/j/k/l>)
                    scrolling = true,          -- Enable scrolling keymaps (<C-f/b>) for page up/down
                },
            })
        end
    }
}
