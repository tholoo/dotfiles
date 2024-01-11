return {
  "hrsh7th/nvim-cmp",
  opts = {
    window = {
      completion = require("cmp.config.window").bordered({ scrollbar = false }),
      documentation = require("cmp.config.window").bordered(),
    },
    mapping = {
      ["<CR>"] = require("cmp").mapping(function(fallback)
        fallback()
      end),

      ["<C-Space>"] = require("cmp").mapping.confirm({
        behavior = require("cmp").ConfirmBehavior.Insert,
        select = true,
      }),
    },
  },
}
