return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = { "nvim-lua/plenary.nvim" },

  config = function()
    require("telescope").setup({})

    -- Fix for newer Neovim: use the built-in treesitter highlighter in previews
    local preview_utils = require("telescope.previewers.utils")
    preview_utils.ts_highlighter = function(bufnr, ft)
      local lang = vim.treesitter.language.get_lang(ft) or ft
      if not lang or lang == "" then
        return false
      end
      return pcall(vim.treesitter.start, bufnr, lang)
    end

    local builtin = require("telescope.builtin")
    local map = vim.keymap.set
    map("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
    map("n", "<C-p>", builtin.git_files, { desc = "Git files" })
    map("n", "<leader>fs", function()
      builtin.grep_string({ search = vim.fn.input("Grep > ") })
    end, { desc = "Grep for text" })
    map("n", "<leader>fws", function()
      builtin.grep_string({ search = vim.fn.expand("<cword>") })
    end, { desc = "Grep word under cursor" })
    map("n", "<leader>pWs", function()
      builtin.grep_string({ search = vim.fn.expand("<cWORD>") })
    end, { desc = "Grep WORD under cursor" })
    map("n", "<leader>vh", builtin.help_tags, { desc = "Help tags" })
    map("n", "<leader>fb", builtin.buffers, { desc = "Open buffers" })
  end,
}

