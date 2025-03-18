return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    -- 🚀 Standard-LSP-Fähigkeiten setzen
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- 🛠 Clangd LSP-Setup (C, C++)
    lspconfig.clangd.setup({
      cmd = { "clangd", "--header-insertion=never", "--fallback-style=none" },
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        -- ❌ SignatureHelp nur für clangd deaktivieren
        if client.name == "clangd" then
          client.server_capabilities.signatureHelpProvider = false
          vim.schedule(function()
            vim.lsp.handlers["textDocument/signatureHelp"] = function() end
          end)
        end
      end,
    })

    -- 🛠 Lua LSP-Setup
    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      settings = {
        Lua = {
          completion = {
            callSnippet = "Replace",
          },
          diagnostics = {
            globals = { "vim" },
          },
        },
      },
    })

    -- 🛠 Markdown LSP (Marksman)
    lspconfig.marksman.setup({
      capabilities = capabilities,
    })

    -- 📦 Mason für automatische LSP-Installation
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = { "clangd", "lua_ls", "marksman" },
    })
  end,
}
