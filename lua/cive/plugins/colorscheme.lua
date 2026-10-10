return {
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
    vim.cmd("colorscheme rose-pine-moon")
    end,
  },
  -- Primeagen's theme. Installed but not active.
  -- To use it: change the line above to vim.cmd("colorscheme rose-pine-moon")
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = true,
    opts = { disable_background = true, styles = { italic = false } },
  },
}

