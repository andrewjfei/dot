return {
    -- diagnostics, code actions and formatting
    "nvimtools/none-ls.nvim",
    dependencies = {
        "nvimtools/none-ls-extras.nvim",
    },
    config = function()
        local null_ls = require("null-ls")

        null_ls.setup({
            sources = {
                -- javascript & typescript
                null_ls.builtins.formatting.prettier,
                require("none-ls.code_actions.eslint"),
                require("none-ls.diagnostics.eslint"),

                -- lua
                null_ls.builtins.formatting.stylua,
            },
        })

        vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { desc = "[G]lobal [F]ormat" })
    end,
}
