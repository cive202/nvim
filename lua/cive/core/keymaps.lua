vim.g.mapleader=" "

local keymap = vim.keymap 

keymap.set("i","jk","<ESC>", {desc = "Exit insert mode with jk" })

keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

