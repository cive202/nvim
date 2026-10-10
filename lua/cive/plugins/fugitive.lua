return {
  "tpope/vim-fugitive",
  confi = function()
    vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Git status" })

    local group = vim.api.nvim_create_augroup("CiveFugitive", {})
    vim.api.nvim_create_autocmd("BufWinEnter", {
      group = group,
      pattern = "*",
      callback = function()
        if vim.bo.ft ~= "fugitive" then
          return
        end
        local opts = { buffer = vim.api.nvim_get_current_buf(), remap = false }
        vim.keymap.set("n", "<leader>p", function() vim.cmd.Git("push") end, opts)
        vim.keymap.set("n", "<leader>P", function() vim.cmd.Git({ "pull", "--rebase" }) end, opts)
        vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts)
      end,
    })

    -- Merge conflicts: take the left / right side
    vim.keymap.set("n", "gu", "<cmd>diffget //2<CR>", { desc = "Take left side" })
    vim.keymap.set("n", "gh", "<cmd>diffget //3<CR>", { desc = "Take right side" })
  end,
}

