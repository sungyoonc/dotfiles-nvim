return {
  -- indicate when code action is available
  {
    "kosayoda/nvim-lightbulb",
    event = "LspAttach",
    config = {
      autocmd = { enabled = true },
    },
  },
}
