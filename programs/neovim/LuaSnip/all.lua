return {
  -- A snippet that expands the trigger "hi" into the string "Hello, world!".
  require("luasnip").snippet(
    { -- Table 1: snippet parameters
      trig = "hi",
      dscr = "An autotriggering snippet that expands 'hi' into 'Hello, world!'",
      regTrig = false,
      priority = 100,
      snippetType = "autosnippet"
    }, -- Table 2: snippet nodes
    { t("Hello, world!") }
  ),

  -- Shorthand
  s(
    { trig = "foo" },
    { t("Another snippet.") }
  ),

  s(
    { trig = "lines", dscr = "Demo: a text node with three lines" },
    {
      t({ "Line 1", "Line 2", "Line 3" })
    }
  )
}
