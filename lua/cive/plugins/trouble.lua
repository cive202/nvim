return {
  "folke/trouble.nvim",
  opts = {},
  cmd = "Trouble",
  keys = {
    { "<leader>tt", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics list" },
    { "]t", function() require("trouble").next({ skip_groups = true, jump = true }) end, desc = "Next Trouble item" },
    { "[t", function() require("trouble").prev({ skip_groups = true, jump = true }) end, desc = "Prev Trouble item" },
  },
}
