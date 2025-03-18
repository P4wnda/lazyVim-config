return {
  "hrsh7th/nvim-cmp",
  dependencies = { "hrsh7th/cmp-nvim-lsp" },
  config = function()
    local cmp = require("cmp")

    cmp.setup({
      sources = cmp.config.sources({
        { name = "nvim_lsp", keyword_length = 1 }, -- 🔥 LSP Autocompletion
        { name = "buffer" },
        { name = "path" },
      }),
      mapping = cmp.mapping.preset.insert({
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      }),
    })
  end,
}
