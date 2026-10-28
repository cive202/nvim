local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Flash yanked text briefly
autocmd("TextYankPost", {
  group = augroup("CiveHighlightYank", {}),
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 40 })
  end,
})

-- Strip trailing whitespace on save
autocmd("BufWritePre", {
  group = augroup("CiveTrimWhitespace", {}),
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

-- YAML is indentation-sensitive; use 2 spaces instead of the global default
autocmd("FileType", {
  group = augroup("CiveYamlIndent", {}),
  pattern = "yaml",
  callback = function()
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.softtabstop = 2
  end,
})

-- LSP keys, only in buffers that have a language server
autocmd("LspAttach", {
  group = augroup("CiveLspAttach", {}),
  callback = function(e)
    local o = function(desc) return { buffer = e.buf, desc = desc } end
    local map = vim.keymap.set
    map("n", "gd", vim.lsp.buf.definition, o("Go to definition"))
    map("n", "K", vim.lsp.buf.hover, o("Hover docs"))
    map("n", "gr", vim.lsp.buf.references, o("References"))
    map("n", "<leader>ca", vim.lsp.buf.code_action, o("Code action"))
    map("n", "<leader>rn", vim.lsp.buf.rename, o("Rename symbol"))
    map("n", "<leader>ws", vim.lsp.buf.workspace_symbol, o("Workspace symbols"))
    map("i", "<C-s>", vim.lsp.buf.signature_help, o("Signature help"))
  end,
})

