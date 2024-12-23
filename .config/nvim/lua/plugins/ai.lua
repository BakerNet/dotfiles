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
        end,
    }
}
