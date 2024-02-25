return {
  -- preview colors
  {
    "NvChad/nvim-colorizer.lua",
    event = "VeryLazy",
    opts = {},
  },
  {
    "MunifTanjim/nui.nvim",
    lazy = true,
  },
  {
    "stevearc/dressing.nvim",
    opts = {
      select = {
        get_config = function(opts)
          if opts.kind == "codeaction" then
            return {
              backend = { "nui", "builtin" },
              nui = {
                position = { row = 2, col = 1 },
                relative = "cursor",
                min_height = 0,
                max_height = 20,
              },
            }
          end
        end,
      },
    },
  },
}
