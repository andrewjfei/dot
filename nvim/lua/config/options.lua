local opt = vim.opt

-- line numbers
opt.number = true         -- show file line numbers
opt.relativenumber = true -- show line numbers relative to current line

-- tabs & indentation
opt.tabstop = 4       -- amount of spaces for tabs
opt.shiftwidth = 4    -- amount of spaces for indentation
opt.expandtab = true  -- expand tabs to spaces
opt.autoindent = true -- copy current line indent when starting a new line

-- search
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true  -- assume case sensitive if searching with mixed case

-- clipboard
vim.schedule(function()
    opt.clipboard = "unnamedplus" -- copy to system clipboard
end)

-- split windows
opt.splitright = true -- split vertical window to right
opt.splitbelow = true -- split horizontal window to bottom

-- lines
opt.cursorline = true -- highlight current line cursor is on
opt.scrolloff = 10    -- minimum number of lines above and below

-- timings
opt.updatetime = 250 -- decrease update time
opt.timeoutlen = 300 -- decrease keymap sequence timeout

-- misc
opt.swapfile = false   -- disable swap files
opt.signcolumn = "yes" -- allows enable sign column to prevent text shift
opt.showmode = false   -- disable mode in since it is in status line
