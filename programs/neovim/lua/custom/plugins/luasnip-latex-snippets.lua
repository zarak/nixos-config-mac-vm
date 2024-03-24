-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return
{
  -- dir = "/home/zarak/Projects/luasnip-latex-snippets.nvim",
  -- requires = { "L3MON4D3/LuaSnip", "lervag/vimtex" },
  -- config = function()
  --   require 'luasnip-latex-snippets'.setup()
  -- end,

  "iurimateus/luasnip-latex-snippets.nvim",
  -- vimtex isn't required if using treesitter
  -- commit = "820dbb05c5cc7706f2d1ca861d9e7ec7269738d8",
  dependencies = { "L3MON4D3/LuaSnip", "lervag/vimtex" },
  -- lazy = false,
  config = function()
    require 'luasnip-latex-snippets'.setup()
    -- or setup({ use_treesitter = true })
  end,
}
