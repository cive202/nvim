-- Needs Neovim 0.11+ (uses vim.lsp.config).
-- Add more servers to ensure_installed, e.g. "gopls", "rust_analyzer", "pyright".
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
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
