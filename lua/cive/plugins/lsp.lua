-- Needs Neovim 0.11+ (uses vim.lsp.config).
-- Add more servers to ensure_installed, e.g. "gopls", "rust_analyzer", "pyright".
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "mason-org/mason.nvim",
    "mason-org/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/nvim-cmp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "j-hui/fidget.nvim",
    "b0o/schemastore.nvim",
  },

  config = function()
    local cmp = require("cmp")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Every server gets completion capabilities
    vim.lsp.config("*", { capabilities = capabilities })

    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          runtime = { version = "LuaJIT" },
          diagnostics = { globals = { "vim" } },
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME,
              vim.fn.stdpath("data") .. "/lazy/lazy.nvim",
            },
          },
        },
      },
    })

    vim.lsp.config("yamlls", {
      settings = {
        yaml = {
          validate = true,
          format = { enable = true },
          schemaStore = { enable = false, url = "" },
          schemas = require("schemastore").yaml.schemas(),
        },
      },
    })

    require("fidget").setup({})
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "pyright",
        "vtsls",
        "clangd",
        "yamlls",
      },
      automatic_enable = true,
    })

    -- Completion: Ctrl-n / Ctrl-p to move, Ctrl-y to accept, Ctrl-Space to open
    local select = { behavior = cmp.SelectBehavior.Select }
    cmp.setup({
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item(select),
        ["<C-n>"] = cmp.mapping.select_next_item(select),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
      }, {
        { name = "buffer" },
        { name = "path" },
      }),
    })

    -- SQL language server (disabled: sql-language-server isn't installed).
    -- Install with `npm i -g sql-language-server`, then uncomment.
    -- vim.lsp.config("sqlls", {
    --   cmd = { "sql-language-server", "up", "--method", "stdio" },
    --   filetypes = { "sql", "mysql" },
    --   root_markers = { ".sqllsrc.json" },
    -- })
    -- vim.lsp.enable("sqlls")

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("CiveLspPlugin", { clear = true }),
      callback = function(ev)
        local function map(lhs, rhs, desc)
          vim.keymap.set("n", lhs, rhs, { buffer = ev.buf, desc = desc })
        end
        map("gd", vim.lsp.buf.definition, "LSP: Go to definition")
        map("gD", vim.lsp.buf.declaration, "LSP: Go to declaration")
        map("gr", vim.lsp.buf.references, "LSP: References")
        map("gi", vim.lsp.buf.implementation, "LSP: Go to implementation")
        map("K", vim.lsp.buf.hover, "LSP: Hover docs")
        map("<leader>rn", vim.lsp.buf.rename, "LSP: Rename symbol")
        map("<leader>ca", vim.lsp.buf.code_action, "LSP: Code action")
      end,
    })

    vim.diagnostic.config({
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    })
  end,
}
