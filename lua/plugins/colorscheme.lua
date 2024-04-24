---@param name string
local function apply(name)
  vim.cmd(string.format([[colorscheme %s]], name))

  vim.cmd([[
    hi DiagnosticUnderlineError gui=undercurl
    hi DiagnosticUnderlineWarn gui=undercurl
    hi DiagnosticUnderlineInfo gui=undercurl
    hi DiagnosticUnderlineHint gui=undercurl
    hi DiagnosticUnderlineOk gui=undercurl
  ]])
end

return {
  -- catppuccin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        show_end_of_buffer = true,
      })
      if os.getenv("DISPLAY") == nil then
        apply("default")
      else
        apply("catppuccin")
      end
    end,
  },
}
