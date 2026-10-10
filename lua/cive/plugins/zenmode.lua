return {
  "folke/zen-mode.nvim",
  opts = { window = { width = 90 } },
  keys = {
    { "<leader>zz", function() require("zen-mode").toggle() end, desc = "Zen mode" },
  },
}

