return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets",
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    -- Snippets aus VSCode laden
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      sources = cmp.config.sources({
        {
          name = "nvim_lsp",
          keyword_length = 1,
          max_item_count = 10,
          entry_filter = function(entry, ctx)
            return entry.source.name ~= "nvim_lsp" or entry:get_completion_item().insertTextFormat ~= 2
          end,
        },
        { name = "luasnip" }, -- ✅ Only keep LuaSnip snippets
        { name = "buffer" },
        { name = "path" },
      }),
      mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Enter bestätigt Auswahl
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
    })
  end,
}
