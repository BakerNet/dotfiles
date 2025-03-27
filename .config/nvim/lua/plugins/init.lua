return {
    -- Tmux move with C-h/j/k/l
    'christoomey/vim-tmux-navigator',

    -- Change history
    { 'mbbill/undotree' },

    -- Slidedeck presentation
    {
        'BakerNet/present.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {},
    }
}
