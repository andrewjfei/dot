return {
    {
        -- neovim autocompletion
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            {
                -- snippet engine
                "L3MON4D3/LuaSnip",
                dependencies = {
                    {
                        -- premade snippets
                        "rafamadriz/friendly-snippets",
                        config = function()
                            require("luasnip.loaders.from_vscode").lazy_load()
                        end,
                    },
                },
            },
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            -- setup lausnip configuration
            luasnip.config.setup({})

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                completion = {
                    completeopt = "menu,menuone,noinsert",
                },
                window = {
                    completion = cmp.config.window.bordered({
                        border = {
                            "┌", -- top-left
                            "─", -- top
                            "┐", -- top-right
                            "│", -- right
                            "┘", -- bottom-right
                            "─", -- bottom
                            "└", -- bottom-left
                            "│", -- left
                        },
                        winhighlight = "Normal:Normal,FloatBorder:Normal,CursorLine:IncSearch,Search:None",
                        side_padding = 1,
                    }),
                    documentation = cmp.config.window.bordered({
                        border = {
                            "┌", -- top-left
                            "─", -- top
                            "┐", -- top-right
                            "│", -- right
                            "┘", -- bottom-right
                            "─", -- bottom
                            "└", -- bottom-left
                            "│", -- left
                        },
                        winhighlight = "Normal:Normal,FloatBorder:Normal,CursorLine:CursorLine,Search:None",
                    }),
                },
                mapping = cmp.mapping.preset.insert({
                    -- select next suggestion
                    ["<C-l>"] = cmp.mapping.select_next_item(),

                    -- select previous suggestion
                    ["<C-h>"] = cmp.mapping.select_prev_item(),

                    -- scroll down suggestions list
                    ["<C-k>"] = cmp.mapping.scroll_docs(4), -- might be mapping conflict

                    -- scroll up suggestions list
                    ["<C-j>"] = cmp.mapping.scroll_docs(-4), -- might be mapping conflict

                    -- manually trigger suggestions
                    ["<C-Space>"] = cmp.mapping.complete(),

                    -- close autocompletion floating window
                    ["<C-c>"] = cmp.mapping.abort(),

                    -- confirm autocompletion suggestion
                    ["<C-CR>"] = cmp.mapping.confirm({ select = true }),
                }),
                sources = {
                    {
                        name = "lazydev",

                        -- skip loading lua_ls completions (recommended)
                        group_index = 0,
                    },
                    { name = "luasnip" },
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                    { name = "path" },
                },
            })
        end,
    },
}
