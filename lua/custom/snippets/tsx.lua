require("luasnip.session.snippet_collection").clear_snippets("typescriptreact")

local ls = require("luasnip")

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("all", {
  s("clg", {
    fmt("console.log({}){}", { i(1), i(2) }),
  }),
})
