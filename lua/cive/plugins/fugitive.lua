
return {
  "tpope/vim-fugitive",

  config = function()
    local map = vim.keymap.set

    -- Git command center
    map("n", "<leader>gs", "<cmd>Git<CR>",
      { desc = "Git: Status" })

    map("n", "<leader>gd", "<cmd>Gdiffsplit<CR>",
      { desc = "Git: Diff" })

    -- Staging
    map("n", "<leader>ga", "<cmd>Git add %<CR>",
      { desc = "Git: Stage current file" })

    map("n", "<leader>gA", "<cmd>Git add -A<CR>",
      { desc = "Git: Stage all changes" })

    -- Unstage everything
    map("n", "<leader>gu", "<cmd>Git reset<CR>",
      { desc = "Git: Unstage all changes" })

    -- Commit
    map("n", "<leader>gc", "<cmd>Git commit<CR>",
      { desc = "Git: Commit staged changes" })

    -- Push
    map("n", "<leader>gp", "<cmd>Git push<CR>",
      { desc = "Git: Push" })

    -- Push current branch and set upstream
    map("n", "<leader>gP", function()
      local branch = vim.fn.system(
        "git branch --show-current"
      ):gsub("%s+$", "")

      if vim.v.shell_error ~= 0 or branch == "" then
        vim.notify(
          "Could not determine current Git branch",
          vim.log.levels.WARN
        )
        return
      end

      vim.cmd("Git push -u origin "
        .. vim.fn.shellescape(branch))
    end, { desc = "Git: Push new branch" })

    -- Merge conflict helpers
    map("n", "gu", "<cmd>diffget //2<CR>",
      { desc = "Git: Take left side" })

    map("n", "gh", "<cmd>diffget //3<CR>",
      { desc = "Git: Take right side" })
  end,
}

