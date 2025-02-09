-- [[ Configure Autoformatting ]]
-- Use your language server to automatically format your code on save.
-- Adds additional commands as well to manage the behavior
local setup_autoformat = function()
    -- Switch for controlling whether you want autoformatting.
    --  Use :KickstartFormatToggle to toggle autoformatting on or off
    local format_is_enabled = true
    vim.api.nvim_create_user_command('KickstartFormatToggle', function()
        format_is_enabled = not format_is_enabled
        print('Setting autoformatting to: ' .. tostring(format_is_enabled))
    end, {})

    -- Create an augroup that is used for managing our formatting autocmds.
    --      We need one augroup per client to make sure that multiple clients
    --      can attach to the same buffer without interfering with each other.
    local _augroups = {}
    local get_augroup = function(client)
        if not _augroups[client.id] then
            local group_name = 'kickstart-lsp-format-' .. client.name
            local id = vim.api.nvim_create_augroup(group_name, { clear = true })
            _augroups[client.id] = id
        end

        return _augroups[client.id]
    end

    -- Whenever an LSP attaches to a buffer, we will run this function.
    --
    -- See `:help LspAttach` for more information about this autocmd event.
    vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach-format', { clear = true }),
        -- This is where we attach the autoformatting for reasonable clients
        callback = function(args)
            local client_id = args.data.client_id
            local client = vim.lsp.get_client_by_id(client_id)
            local bufnr = args.buf

            -- Only attach to clients that support document formatting
            if not client.server_capabilities.documentFormattingProvider then
                return
            end

            -- Typescript-language-server usually works poorly. Sorry you work with bad languages
            -- You can remove this line if you know what you're doing :)
            if client.name == 'ts_ls' then
                return
            end

            -- Create an autocmd that will run *before* we save the buffer.
            --  Run the formatting command for the LSP that has just attached.
            vim.api.nvim_create_autocmd('BufWritePre', {
                group = get_augroup(client),
                buffer = bufnr,
                callback = function()
                    if not format_is_enabled then
                        return
                    end

                    local async = false
                    -- black is too slow - only worth with async
                    local venv_path = os.getenv('VIRTUAL_ENV')
                    if venv_path ~= nil then
                        async = true
                    end


                    vim.lsp.buf.format {
                        async = async,
                        filter = function(c)
                            return c.id == client.id
                        end,
                    }
                end,
            })
        end,
    })
    vim.keymap.set('n', '<leader>tf', '<Cmd>KickstartFormatToggle<CR>', { desc = '[T]oggle Auto-[F]ormatting' })
end

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local setup_lsp = function()
    local on_attach = function(_, bufnr)
        -- NOTE: Remember that lua is a real programming language, and as such it is possible
        -- to define small helper and utility functions so you don't have to repeat yourself
        -- many times.
        --
        -- In this case, we create a function that lets us more easily define mappings specific
        -- for LSP related items. It sets the mode, buffer and description for us each time.
        local nmap = function(keys, func, desc)
            if desc then
                desc = 'LSP: ' .. desc
            end

            vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        end

        -- Remove these after neovim 0.11 (builtin)
        nmap('grn', vim.lsp.buf.rename, '[R]e[n]ame')
        nmap('gra', vim.lsp.buf.code_action, '[C]ode [A]ction')
        nmap('gri', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
        -- End Remove after neovim 0.11
        nmap('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
        nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
        nmap('<leader>sd', require('telescope.builtin').lsp_document_symbols, '[S]ymbols in [D]ocument')
        nmap('<leader>sw', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[S]ymbols in [W]orkspace')

        -- See `:help K` for why this keymap
        nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
        nmap('<leader>K', vim.lsp.buf.signature_help, 'Signature Documentation')

        -- Lesser used LSP functionality
        nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
        nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
        nmap('<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, '[W]orkspace [L]ist Folders')

        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
            vim.lsp.buf.format()
        end, { desc = 'Format current buffer with LSP' })
    end

    -- Enable the following language servers
    --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
    --
    --  Add any additional override configuration in the following tables. They will be passed to
    --  the `settings` field of the server config. You must look up that documentation yourself.
    local servers = {
        -- clangd = {},
        -- pyright = {},
        gopls = {},
        rust_analyzer = {
            ["rust-analyzer"] = {
                cargo = {
                    features = "all",
                },
                -- rustfmt = {
                --     overrideCommand = { "leptosfmt", "--stdin", "--rustfmt" },
                -- },
            },
        },
        ts_ls = {},
        lua_ls = {
            Lua = {
                workspace = { checkThirdParty = false },
                telemetry = { enable = false },
            },
        },
        basedpyright = {
            diagnosticMode = "openFilesOnly",
            reportMissingTypeStubs = false,
        }
        -- pylsp = {
        --     pylsp = {
        --         plugins = {
        --             -- formatter options
        --             black = { enabled = false },
        --             autopep8 = { enabled = false },
        --             yapf = { enabled = false },
        --             -- linter options
        --             ruff = { enabled = true },
        --             pylint = { enabled = false, executable = "pylint" },
        --             pyflakes = { enabled = false },
        --             pycodestyle = { enabled = false },
        --             mccabe = { enabled = false },
        --             flake8 = { enabled = false },
        --             -- type checker
        --             pylsp_mypy = { enabled = false },
        --             -- auto-completion options
        --             jedi_completion = { fuzzy = true },
        --             -- import sorting
        --             isort = { enabled = true },
        --             -- code actions
        --             rope_autoimport = { enabled = true },
        --         },
        --     },
        -- },
    }

    -- Setup neovim lua configuration
    require('neodev').setup()

    -- blink.cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

    -- Ensure the servers above are installed
    local mason_lspconfig = require 'mason-lspconfig'

    mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(servers),
    }

    mason_lspconfig.setup_handlers {
        function(server_name)
            require('lspconfig')[server_name].setup {
                capabilities = capabilities,
                on_attach = on_attach,
                settings = servers[server_name],
            }
        end,
    }

    for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
        local default_diagnostic_handler = vim.lsp.handlers[method]
        vim.lsp.handlers[method] = function(err, result, context)
            if err ~= nil and err.code == -32802 then
                return
            end
            return default_diagnostic_handler(err, result, context)
        end
    end
end

-- LSP Configuration & Plugins
return {
    'neovim/nvim-lspconfig',
    dependencies = {
        -- Automatically install LSPs to stdpath for neovim
        { 'williamboman/mason.nvim', config = true },
        'williamboman/mason-lspconfig.nvim',

        -- Useful status updates for LSP
        -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
        { 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },

        -- Additional lua configuration, makes nvim stuff amazing!
        'folke/neodev.nvim',
    },
    config = function()
        setup_autoformat()
        setup_lsp()
    end,
}
