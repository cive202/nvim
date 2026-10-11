-- Needs Neovim 0.11+ and the tree-sitter CLI (`npm i -g tree-sitter-cli`
-- or your package manager) because this uses the new nvim-treesitter API.
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      local parsers = {
        "lua", "vim", "vimdoc", "query","python",
        "javascript", "typescript", "tsx", "html", "css", "json",
        "gitignore", "go", "php",
      }

      require("nvim-treesitter").install(parsers)

      -- Turn on treesitter highlighting for normal file buffers
      vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
        group = vim.api.nvim_create_augroup("CiveTreesitter", { clear = true }),
        callback = function()
          if vim.bo.buftype ~= "" then
            return
          end
          pcall(vim.treesitter.start, 0)
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    lazy = false,
    config = function()
      require("nvim-treesitter-textobjects").setup({ select = { lookahead = true } })
      local select = require("nvim-treesitter-textobjects.select")
      vim.keymap.set({ "x", "o" }, "af", function()
        select.select_textobject("@function.outer", "textobjects")
      end, { desc = "Around function" })
      vim.keymap.set({ "x", "o" }, "if", function()
        select.select_textobject("@function.inner", "textobjects")
      end, { desc = "Inside function" })
    end,
  },
}

