local map = vim.keymap.set

-- Leader key: Space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Save and quit
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit window" })
map("n", "<leader>x", "<cmd>x<CR>", { desc = "Save and quit" })

-- Clear search highlights
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })
-- Insert mode to normal mode
map("i", "jk", "<Esc>", { desc = "Exit insert mode" })
-- Move between windows using Alt + WASD
map("n", "<A-a>", "<C-w>h", { desc = "Move to left window" })
map("n", "<A-s>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<A-w>", "<C-w>k", { desc = "Move to upper window" })
map("n", "<A-d>", "<C-w>l", { desc = "Move to right window" })-- Indentation
map("v", ">", ">gv", { desc = "Indent right" })
map("v", "<", "<gv", { desc = "Indent left" })

-- Move selected lines
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move lines down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move lines up" })

-- Scrolling
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up" })

-- System clipboard (Linux)
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Copy to system clipboard" })
map({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })

-- Buffers
map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Close buffer" })

-- Built-in file explorer
map("n", "<leader>e", "<cmd>Explore<CR>", { desc = "File explorer" })

-- LSP diagnostics
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic" })

-- Increment/decrement numbers
map("n", "<leader>+", "<C-a>", { desc = "Increment number" })
map("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- Window management
map("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
map("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
map("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
map("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- Tab management
map("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
map("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
map("n", "<leader>tn", "<cmsx>tabn<CR>", { desc = "Go to next tab" })
map("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
map("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })


-- this is the autocomplete 
map("v", "<leader>ai", function()
  local s = vim.fn.line("v")
  local e = vim.fn.line(".")
  if s > e then s, e = e, s end
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "nx", false)

  local buf = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(buf, s - 1, e, false)
  local prompt = table.concat({
    "Complete or finish this code. Any comments describe what it should do.",
    "Reply with ONLY the final replacement code, no markdown fences, no explanation.",
    "Filetype: " .. vim.bo.filetype,
    "",
    table.concat(lines, "\n"),
  }, "\n")

  vim.notify("Claude is working...")
  vim.system({ "claude", "-p", prompt, "--model", "haiku" }, { text = true }, function(res)
    vim.schedule(function()
      if res.code ~= 0 then
        return vim.notify("Claude failed: " .. (res.stderr or ""), vim.log.levels.ERROR)
      end
      local out = res.stdout:gsub("^```%w*\n", ""):gsub("\n```%s*$", ""):gsub("%s+$", "")
      vim.api.nvim_buf_set_lines(buf, s - 1, e, false, vim.split(out, "\n"))
    end)
  end)
end, { desc = "Claude: complete selection" })
