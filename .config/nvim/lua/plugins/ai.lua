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
    }
}
