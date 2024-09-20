vim.g.mapleader = " "      -- global leader
vim.g.maplocalleader = " " -- local buffer leader

local keymap = vim.keymap

-- clear highlights
keymap.set("n", "<leader>ch", ":nohl<CR>", { desc = "[c]lear [h]highlights" })

-- window split
keymap.set("n", "<leader>wh", "<C-w>v", { desc = "[w]indow split [h]orizontally" })
keymap.set("n", "<leader>wv", "<C-w>s", { desc = "[w]indow split [v]eritically" })
keymap.set("n", "<leader>we", "<C-w>=", { desc = "[w]indow split [e]qual size" })

-- window tab
keymap.set("n", "<leader>wo", "<cmd>tabnew<CR>", { desc = "[w]indow [o]pen new tab" })
keymap.set("n", "<leader>wn", "<cmd>tabn<CR>", { desc = "[w]indow [n]ext tab" })
keymap.set("n", "<leader>wp", "<cmd>tabp<CR>", { desc = "[w]indow [p]revious tab" })
keymap.set("n", "<leader>wc", "<cmd>close<CR>", { desc = "[w]indow [c]lose" })

-- window navigation
keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to left window" })
keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to right window" })
keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to top window" })
keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to bottom window" })

-- diagnostics
keymap.set("n", "<leader>dq", vim.diagnostic.setloclist, { desc = "[d]iagnostic [q]uickfix list" })
