-- Color theme (matches GMK keycaps on the 7V daily driver)
return {
    'EdenEast/nightfox.nvim',
    lazy = false,
    priority = 1000,
    config = function()
        -- Load the colorscheme
        vim.cmd('colorscheme nordfox')
    end
}
