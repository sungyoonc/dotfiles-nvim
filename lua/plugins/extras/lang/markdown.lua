return {
  -- markdown preview
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    config = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    event = {
      -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
      -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"

      -- stylua: ignore start
      -- notes
      "BufReadPre " .. vim.fn.expand("~") .. "/syncthing/Notes/notes/**.md",
      "BufNewFile " .. vim.fn.expand("~") .. "/syncthing/Notes/notes/**.md",

      -- reports
      "BufReadPre " .. vim.fn.expand("~") .. "/syncthing/Notes/reports/**.md",
      "BufNewFile " .. vim.fn.expand("~") .. "/syncthing/Notes/reports/**.md",
      -- stylua: ignore end
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      vim.schedule(function()
        vim.cmd([[LspStart markdown_oxide]])
      end)
      -- Enable additional markdown syntax like checkboxes
      vim.opt.conceallevel = 1
      require("obsidian").setup({
        workspaces = {
          {
            name = "notes",
            path = "~/syncthing/Notes/notes",
            overrides = {
              templates = {
                subdir = "university/templates",
                date_format = "%Y-%m-%d",
              },
            },
          },
          {
            name = "reports",
            path = "~/syncthing/Notes/reports",
          },
        },
        disable_frontmatter = true,
      })

      local group = vim.api.nvim_create_augroup("user_marksman_lsp", { clear = true })
      vim.api.nvim_create_autocmd({ "BufWritePre" }, {
        group = group,
        callback = function(event)
          if event.match:match("^%w%w+://") then
            return
          end
          local file = vim.uv.fs_realpath(event.match) or event.match
          vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
        end,
      })

      vim.keymap.set("n", "<localleader>t", ":ObsidianTemplate<CR>", { desc = "Obsidian Templates" })
    end,
  },
}
