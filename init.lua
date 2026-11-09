require("cive.core")
require("cive.lazy")

vim.g.python3_host_prog = vim.fn.expand("~/.virtualenvs/molten_neovim/bin/python3")



-- ==========================================
-- Persistent Undo
-- ==========================================

local undodir = vim.fn.stdpath("state") .. "/undo"

-- Create undo directory if it doesn't exist
vim.fn.mkdir(undodir, "p")

-- Enable persistent undo
vim.opt.undofile = true

-- Set undo directory
vim.opt.undodir = undodir
