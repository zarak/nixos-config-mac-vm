local ls = require("luasnip")
local fmta = require("luasnip.extras.fmt").fmta
local s = ls.snippet
local i = ls.insert_node
-- local t = ls.text_node
-- local f = ls.function_node

local in_mathzone = function()
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

-- local line_begin = require("luasnip.extras.expand_conditions").line_begin

return {
  -- Latex complains about the empty set symbol \0 in math mode
  --
  -- https://tex.stackexchange.com/questions/196312/command-o-is-invalid-in-mathmode
  s({ trig = "oO", snippetType = "autosnippet", descr = "empty set" },
    fmta(
      [[\varnothing <>]],
      { i(1) }
    ),
    { condition = in_mathzone }
  ),

  -- Arrows
  s({ trig = "<-", snippetType = "autosnippet", descr = "leftarrow" },
    fmta(
      [[\leftarrow <>]],
      { i(1) }
    ),
    { condition = in_mathzone }
  ),

  -- Domain and Range
  s({ trig = "dom", snippetType = "autosnippet", descr = "domain" },
    fmta(
      [[\mathrm{Dom}(<>) <>]],
      { i(1), i(2) }
    ),
    { condition = in_mathzone }
  ),

  s({ trig = "ran", snippetType = "autosnippet", descr = "range" },
    fmta(
      [[\mathrm{Ran}(<>) <>]],
      { i(1), i(2) }
    ),
    { condition = in_mathzone }
  ),

  s({ trig = "cir", snippetType = "autosnippet", descr = "composition" },
    fmta(
      [[\circ <>]],
      { i(1) }
    ),
    { condition = in_mathzone }
  ),

  s({ trig = "mrm", snippetType = "autosnippet", descr = "mathrm" },
    fmta(
      [[\mathrm{<>}]],
      { i(1) }
    ),
    { condition = in_mathzone }
  ),

  -- Category theory
  s({ trig = "cat", snippetType = "autosnippet", descr = "category" },
    fmta(
      [[\mathsf{<>}]],
      { i(1) }
    ),
    { condition = in_mathzone }
  ),

  s({ trig = "hom", snippetType = "autosnippet", dscr = "morphism" },
    fmta(
      [[ \mathrm{Hom}_{\mathsf{<>}}(<>) ]],
      {
        i(1),
        i(2)
      }
    ),
    { condition = in_mathzone }
  ),

  s({ trig = "cong", snippetType = "autosnippet", descr = "isomorphism" },
    fmta(
      [[\cong <>]],
      { i(1) }
    ),
    { condition = in_mathzone }
  ),

  -- Some keybindings to match Agda unicode
  s({ trig = "\\r", snippetType = "autosnippet", descr = "to" },
    fmta(
      [[\to <>]],
      { i(1) }
    ),
    { condition = in_mathzone }
  ),

  s({ trig = "\\ex", snippetType = "autosnippet", descr = "exists" },
    fmta(
      [[\exists \,<>]],
      { i(1) }
    ),
    { condition = in_mathzone }
  ),

  s({ trig = "\\all", snippetType = "autosnippet", descr = "forall" },
    fmta(
      [[\forall \,<>]],
      { i(1) }
    ),
    { condition = in_mathzone }
  ),

  s({ trig = "\\bN", snippetType = "autosnippet", descr = "Natural numbers" },
    fmta(
      [[\mathbb{N} <>]],
      { i(1) }
    ),
    { condition = in_mathzone }
  ),

  ---------------------------------------------------
  -- Examples of complete snippets using fmt and fmta
  ---------------------------------------------------

  -- \texttt
  -- s({ trig = "tt", dscr = "Expands 'tt' into '\texttt{}'" },
  --   fmta(
  --     "\\texttt{<>}",
  --     { i(1) }
  --   )
  -- ),

  --
  -- \frac
  -- s({ trig = "ff" },
  --   fmta(
  --     "\\frac{<>}{<>}",
  --     {
  --       i(1),
  --       i(2),
  --     }
  --   ),
  --   { condition = in_mathzone } -- `condition` option passed in the snippet `opts` table
  -- ),
  --


  --
  -- s({ trig = '([^%a])ff', regTrig = true, wordTrig = false },
  --   fmta(
  --     [[<>\frac{<>}{<>}]],
  --     {
  --       f(function(_, snip) return snip.captures[1] end),
  --       i(1),
  --       i(2)
  --     }
  --   )
  -- ),


  --
  -- Equation
  -- s({ trig = "eq", dscr = "Expands 'eq' into an equation environment" },
  --   fmta(
  --     [[
  --      \begin{equation*}
  --          <>
  --      \end{equation*}
  --    ]],
  --     { i(1) }
  --   )
  -- ),
  --
  -- s({ trig = "new", dscr = "A generic new environmennt" },
  --   fmta(
  --     [[
  --     \begin{<>}
  --         <>
  --     \end{<>}
  --   ]],
  --     {
  --       i(1),
  --       i(2),
  --       rep(1),
  --     }
  --   ),
  --   { condition = line_begin }
  -- ),
}
