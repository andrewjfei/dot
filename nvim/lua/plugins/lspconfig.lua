return {
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                {
                    path = "luvit-meta/library",
                    words = { "vim%.uv" },
                },
            },
        },
    },
    {
        "Bilal2453/luvit-meta",
        lazy = true,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                "williamboman/mason.nvim",
                config = true,
            },
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            -- this fuction is executed every time an lsp attaches to a particular buffer (i.e. ts_ls for .js or .ts files)
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
                callback = function(event)
                    -- key mappings
                    local map = function(keys, func, desc, mode)
                        mode = mode or "n"
                        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                    end

                    -- go to definition of token under cursor
                    map("gd", require("telescope.builtin").lsp_definitions, "[g]o to [d]efinition")

                    -- find references for the word under cursor
                    map("gr", require("telescope.builtin").lsp_references, "[g]o to [r]eferences")

                    -- go to implementation of the word under cursor
                    map("gi", require("telescope.builtin").lsp_implementations, "[g]o to [i]mplementation")

                    -- go to the type of the word under cursor
                    map("<leader>d", require("telescope.builtin").lsp_type_definitions, "type [d]efinition")

                    -- fuzzy find all the symbols in your current document (i.e. variables, functions, types, etc.)
                    map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[d]ocument [s]ymbols")

                    -- Fuzzy find all the symbols in your current workspace.
                    --  Similar to document symbols, except searches over your entire project.
                    map(
                        "<leader>ws",
                        require("telescope.builtin").lsp_dynamic_workspace_symbols,
                        "[w]orkspace [s]ymbols"
                    )

                    -- rename variable
                    map("<leader>rn", vim.lsp.buf.rename, "[r]e[n]ame")

                    -- execute a code action (usually your cursor needs to be on top of an error
                    -- or a suggestion from your lsp for this to take effect)
                    map("<leader>ca", vim.lsp.buf.code_action, "[c]ode [a]ction", { "n", "x" })

                    -- got to declaration (i.e. in c this would take you to the header)
                    map("gD", vim.lsp.buf.declaration, "[g]o to [D]eclaration")

                    local client = vim.lsp.get_client_by_id(event.data.client_id)

                    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
                        local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })

                        -- auto command for highlighting word under cursor when cursor is resting
                        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                            buffer = event.buf,
                            group = highlight_augroup,
                            callback = vim.lsp.buf.document_highlight,
                        })

                        -- clear highlights when cursor is moved
                        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                            buffer = event.buf,
                            group = highlight_augroup,
                            callback = vim.lsp.buf.clear_references,
                        })

                        vim.api.nvim_create_autocmd("LspDetach", {
                            group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
                            callback = function(event2)
                                vim.lsp.buf.clear_references()
                                vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
                            end,
                        })
                    end
                end,
            })

            -- define capabilities that should supported to language servers
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

            -- define and configure the language servers that will be used used by mason-lspconfig
            local language_servers = {
                rust_analyzer = {},
                ts_ls = {},
                lua_ls = {
                    settings = {
                        Lua = {
                            completion = {
                                callSnippet = "Replace",
                            },
                            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                            -- diagnostics = { disable = { 'missing-fields' } },
                        },
                    },
                },
                omnisharp = {}, -- csharp
            }

            -- setup mason
            require("mason").setup({})

            -- flatten language server names to be used when installing
            local ensure_installed = vim.tbl_keys(language_servers or {})

            -- setup language servers
            local lspconfig = require("lspconfig")
            require("mason-lspconfig").setup({
                ensure_installed = ensure_installed,
                handlers = {
                    function(name)
                        local language_server = language_servers[name] or {}
                        language_server.capabilities =
                            vim.tbl_deep_extend("force", {}, capabilities, language_server.capabilities or {})
                        lspconfig[name].setup(language_server)
                    end,
                },
            })
        end,
    },
}
