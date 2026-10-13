vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

-- Line numbers
opt.relativenumber = true
opt.number = true

-- Indentation settings
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- General settings
opt.wrap = false
opt.cursorline = true
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- Search settings
opt.ignorecase = true
opt.smartcase = true

-- Backspace
opt.backspace = { "indent", "eol", "start" }

-- System clipboard
opt.clipboard:append("unnamedplus")

-- Split windows
opt.splitright = true
opt.splitbelow = true
