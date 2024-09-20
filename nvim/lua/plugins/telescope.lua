return {
    -- neovim fuzzy finder
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
        require("telescope").setup({
            defaults = {
                file_ignore_patterns = {
                    ".git/",
                    "node_modules/",
                },
                border = true,
                borderchars = {
                    "─", -- top
                    "│", -- right
                    "─", -- bottom
                    "│", -- left
                    "┌", -- top-left
                    "┐", -- top-right
                    "┘", -- bottom-right
                    "└", -- bottom-left
                },
            },
            pickers = {
                find_files = {
                    -- show hidden files in search results
                    hidden = true,
                },
            },
            extensions = {
                require("telescope.themes").get_dropdown(),
            },
        })

        require("telescope").load_extension("ui-select")

        -- telescope keymaps
        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[s]earch [h]elp" })
        vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[s]earch [k]eymaps" })
        vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[s]earch [f]iles" })
        vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[s]earch [s]elect telescope" })
        vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[s]earch current [w]ord" })
        vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[s]earch by [g]rep" })
        vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[s]earch [d]iagnostics" })
        vim.keymap.set("n", "<leader>sr", builtin.oldfiles, { desc = '[s]earch [r]ecent files' })
        vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "[s]earch existing [b]uffers" })
    end,
}
