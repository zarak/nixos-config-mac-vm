-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return
{
  "lervag/vimtex",
  init = function()
    -- vim.g.vimtex_view_general_viewer = 'zathura'
    -- vim.g.vimtex_view_general_options = [[--unique file:@pdf\#src:@line@tex]]
    vim.g.vimtex_view_method = 'zathura'
    vim.g.vimtex_quickfix_enabled = 1
    vim.g.vimtex_syntax_enabled = 1
    vim.g.vimtex_quickfix_mode = 0
    vim.opt_local.conceallevel = 1
    vim.g.vimtex_fold_enabled = 1
  end,
}
