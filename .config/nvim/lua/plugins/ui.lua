return {
    -- Useful plugin to show you pending keybinds.
    { 'folke/which-key.nvim', opts = {} },
    -- Set lualine as statusline
    {
        'nvim-lualine/lualine.nvim',
        -- See `:help lualine.txt`
        opts = {
            options = {
                icons_enabled = false,
                theme = 'onedark',
                component_separators = '|',
                section_separators = '',
            },
        },
    },
    {
        "mikavilpas/yazi.nvim",
        event = "VeryLazy",
        keys = {
            -- 👇 in this section, choose your own keymappings!
            {
                "<leader>e",
                "<cmd>Yazi<cr>",
                desc = "Open yazi at the current file",
            },
        },
        opts = {
            -- if you want to open yazi instead of netrw, see below for more info
            open_for_directories = true,
            keymaps = {
                show_help = '<f1>',
            },
        },
    },
    -- Tab bar at the top like GUI editors
    {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            require("bufferline").setup {
                options = {
                    separator_style = 'slant',
                    show_buffer_close_icons = false,
                    offsets = {
                        {
                            filetype = "NvimTree",
                            text = "File Explorer",
                            highlight = "Directory",
                            separator = true -- use a "true" to enable the default, or set your own character
                        }
                    }
                }
            }

            vim.keymap.set('n', '<leader>bs', '<Cmd>BufferLinePick<CR>', { desc = '[B]uffer [S]elect' })
            vim.keymap.set('n', '<leader>bd', '<Cmd>BufferLinePickClose<CR>', { desc = '[B]uffer [D]elete' })
        end
    },
    -- Clean visual mode
    {
        'folke/zen-mode.nvim',
        event = "VeryLazy",
        config = function()
            vim.keymap.set("n", "<leader>zm", function()
                require("zen-mode").setup {
                    window = {
                        width = 90,
                        options = {}
                    },
                }
                require("zen-mode").toggle()
                vim.wo.wrap = true
                vim.wo.number = true
                vim.wo.rnu = true
            end)
        end
    },
    -- Pretty commandline, messages, and notifications
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            -- add any options here
        },
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        },
        config = function()
            require("noice").setup({
                lsp = {
                    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                    },
                },
                routes = {
                    {
                        filter = { event = "msg_showmode", find = "recording" },
                        view = "notify",
                        opts = {
                            replace = true
                        }
                    },
                },
                -- you can enable a preset for easier configuration
                presets = {
                    command_palette = true, -- position the cmdline and popupmenu together
                },
            })
            vim.keymap.set("n", "<leader>na", function() require('noice').cmd('all') end,
                { desc = "Show [N]oice list [A]ll" })
            vim.keymap.set("n", "<leader>nd", function() require('noice').cmd('dismiss') end,
                { desc = "[N]oice [D]ismiss messages" })
            vim.keymap.set("n", "<leader>nl", function() require('noice').cmd('last') end,
                { desc = "[N]oice [L]ast message" })
        end
    },
    -- Better vim.ui.select and vim.ui.input
    {
        "stevearc/dressing.nvim",
        opts = {},
    }
}
