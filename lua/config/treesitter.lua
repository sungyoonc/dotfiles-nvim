local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

require("nvim-treesitter.configs").setup({
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "vimdoc", "lua", "c", "java", "python", "rust", "toml", "hyprlang" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "" }, -- List of parsers to ignore installing

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true, -- false will disable the whole extension

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    --
    -- list of language that will be disabled
    -- disable = { "" }, -- list of language that will be disabled
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, bufnr)
      local is_large = vim.api.nvim_buf_line_count(bufnr) > 2000
      if is_large then
        print("Tree-sitter disabled due to code size.")
        return true
      end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true, disable = { "yaml" } },
})
