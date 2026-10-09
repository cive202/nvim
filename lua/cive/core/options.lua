vim.cmd("let g:netrw_liststyle = 3")
local opt = vim.opt 

opt.relativenumber = true

local opt = vim.opt 

opt.relativenumber = true
opt.number  = true 

-- Indentation settings
opt.tabstop = 2        -- A tab character displays as 4 spaces
opt.shiftwidth = 2     -- Indent by 4 spaces
opt.expandtab = true   -- Convert tabs into spaces
opt.autoindent = true  -- Copy indentation from previous line


opt.wrap = false 

--search settings
opt.ignorecase = true -- ignore case sensistivity
opt.smartcase = true  -- smartcase sensitive

opt.cursorline = true 

-- Enable true colors for Tokyo Night
opt.termguicolors = true

-- Use a dark colorscheme background
opt.background = "dark"

-- Keep text aligned when diagnostics or signs appear
opt.signcolumn = "yes"

opt.backspace = { "indent", "eol", "start" }

opt.clipboard:append("unnamedplus") --use systemclipboard as a default register

-- split windows
opt.splitright = true
opt.splitbelow = true

