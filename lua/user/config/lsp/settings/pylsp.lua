local root_files = {
  "pyproject.toml",
  "setup.py",
  "setup.cfg",
  "requirements.txt",
  "Pipfile",
  ".git",
}
local root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1])

local function mypy_cache_dir()
  local dir

  if root_dir == nil then
    dir = vim.fn.fnamemodify("~/.python/pylsp_mypy/workspace/standalone", ":p")
  else
    local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
    dir = vim.fn.fnamemodify("~/.python/pylsp_mypy/workspace/projects", ":p") .. project_name
  end
  return dir
end

return {
  settings = {
    pylsp = {
      -- refactoring options
      rope = {
        ropeFolder = nil,
      },
      plugins = {
        -- formatter options
        black = { enabled = false },
        autopep8 = { enabled = false },
        yapf = { enabled = false },

        -- linter options
        pyflakes = { enabled = false },
        mccabe = { enabled = false },
        pycodestyle = { enabled = false },
        pylint = { enabled = false, executable = "pylint" },
        flake8 = { enabled = false },

        --
        -- Jedi
        --
        -- auto-completion options
        jedi_completion = { enabled = true, fuzzy = true },

        --
        -- Plugins
        --
        -- ruff: linter & formatter
        ruff = {
          enabled = true,
          extendSelect = { "I" },
          severities = {
            ["F401"] = "W", -- Set `unused import error` to warning
            ["F841"] = "W", -- Set `local variable unused error` to warning
          },
        },
        -- type checker
        pylsp_mypy = {
          enabled = true,
          strict = false,
          -- using --allow-untyped-globals works too
          overrides = {
            "--disable-error-code",
            "var-annotated",

            "--cache-dir",
            mypy_cache_dir(),

            "--python-executable",
            "python",

            true,
          },
        },
        -- detect deprecated API
        pyls_memestra = { enabled = true },
      },
    },
  },
}
