vim.keymap.set("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local options = {
  number = true, -- set numbered lines
  relativenumber = true, -- set relative numbered lines
  numberwidth = 4, -- minimal number of columns to use for the line number

  tabstop = 8, -- insert 2 spaces for a tab
  softtabstop = 0, -- the number of columns of whitespace a tab keypress or a backspace keypress is worth
  shiftwidth = 4, -- the number of spaces inserted for each indentation
  expandtab = true, -- convert tabs to spaces

  smartcase = true, -- smart case
  smartindent = true, -- make indenting smarter again

  wrap = false, -- display lines as one long line, or true to wrap within screen
  linebreak = false, -- companion to wrap, don't split words

  swapfile = true, -- creates a swapfile
  backup = false, -- creates a backup file
  -- writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  undodir = os.getenv("HOME") .. "/.vim/undodir",
  undofile = true, -- enable persistent undo

  hlsearch = true, -- highlight all matches on previous search pattern
  incsearch = true, -- shows where the pattern is, as the search command is being typed
  ignorecase = true, -- ignore case in search patterns

  scrolloff = 8, -- minimal number of screen lines to keep above and below the cursor
  sidescrolloff = 8, -- minimal number of vertical screen columns to keep right and left of the cursor
  signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time, sign is the icon that shows in the left(error, warning...) by LSP or something

  cursorline = true, -- highlight the current line
  -- colorcolumn = { "80", "120" },           -- shwos a verical lines(columns) at a specific column

  updatetime = 300, -- faster completion (4000ms default)
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp

  conceallevel = 0, -- so that `` is visible in markdown files

  showtabline = 1, -- show tabline(tab list) (0: never 1: only if there are at least two tab pages 2: always)
  cmdheight = 1, -- more space in the neovim command line for displaying messages
  timeoutlen = 1000, -- time to wait for a mapped key sequence to complete (in milliseconds)
  showmode = true, -- show modes like -- INSERT --

  splitbelow = true, -- force all horizontal splits to go below current window
  splitright = true, -- force all vertical splits to go to the right of current window

  clipboard = "unnamedplus", -- allows neovim to access the system clipboard

  pumheight = 10, -- pop up menu height
  mouse = "a", -- allow the mouse to be used in neovim
  fileencoding = "utf-8", -- the encoding written to a file
  guifont = "monospace:h17", -- the font used in graphical neovim applications
  termguicolors = true, -- set term gui colors (most terminals support this)
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- vim.opt.shortmess = "ilmnrx"                        -- flags to shorten vim messages, see :help 'shortmess'
vim.opt.shortmess:append("c") -- don't give |ins-completion-menu| messages
-- vim.opt.iskeyword:append "-"                           -- hyphenated words recognized by searches
vim.opt.formatoptions:remove({ "c", "r", "o" }) -- don't insert the current comment leader automatically for auto-wrapping comments using 'textwidth', hitting <Enter> in insert mode, or hitting 'o' or 'O' in normal mode.
vim.opt.runtimepath:remove("/usr/share/vim/vimfiles") -- separate vim plugins from neovim in case vim still in use
