return {
    -- syntax highlighting
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "bash",
                "c_sharp",
                "diff",
                "dockerfile",
                "html",
                "javascript",
                "jsdoc",
                "lua",
                "luadoc",
                "markdown",
                "markdown_inline",
                "query",
                "rust",
                "sql",
                "toml",
                "typescript",
                "vim",
                "vimdoc",
                "xml",
                "yaml",
            },
            sync_install = false,
            -- auto install languages that are not installed
            auto_install = true,
            ignore_install = {},
            modules = {},
            highlight = {
                enable = true,
                -- some languages depend on regex highlighting system (i.e. ruby) for indent rules
                -- if experiencing weird indenting issues, add language to the list below and disable from indent
                additional_vim_regex_highlighting = { "ruby" },
            },
            indent = {
                enable = true,
                disable = { "ruby" },
            },
        })
    end,
}
