vim.opt.clipboard = "unnamedplus"
vim.opt.relativenumber = true
vim.opt.spelllang = "en_us"
vim.opt.spell = false
vim.opt.spelloptions = "camel"
vim.opt.autoread = true
vim.opt.statusline = "%F"

lvim.termguicolors = true

-- local lspconfig = require("lspconfig")
-- MasonInstall htmx-lsp
-- lspconfig.htmx.setup {
--   filetypes = { "html", "templ" },
-- }
-- lspconfig.tailwindcss.setup {
--   filetypes = { "html", "templ", "vue" }
-- }
-- lspconfig.jsonls.setup {
--   filetypes = { "json", "jsonc" }
-- }
-- lspconfig.eslint.setup {
--   filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" }
-- }

lvim.plugins = {
  { "joerdav/templ.vim" },
  { "ThePrimeagen/vim-be-good" },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({})
    end
  },
  {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = false,
    opts = {
      formatters_by_ft = {
        ["javascript"] = { { "prettierd", "prettier" } },
        ["javascriptreact"] = { { "prettierd", "prettier" } },
        ["typescript"] = { { "prettierd", "prettier" } },
        ["typescriptreact"] = { { "prettierd", "prettier" } },
        ["vue"] = { { "prettierd", "prettier" } },
        ["css"] = { { "prettierd", "prettier" } },
        ["scss"] = { { "prettierd", "prettier" } },
        ["less"] = { { "prettierd", "prettier" } },
        ["html"] = { { "prettierd", "prettier" } },
        ["json"] = { { "prettierd", "prettier" } },
        ["jsonc"] = { { "prettierd", "prettier" } },
        ["yaml"] = { { "prettierd", "prettier" } },
        ["markdown"] = { { "prettierd", "prettier" } },
        ["markdown.mdx"] = { { "prettierd", "prettier" } },
        ["graphql"] = { { "prettierd", "prettier" } },
        ["handlebars"] = { { "prettierd", "prettier" } },
        ["go"] = { { "gofmt" } }
      },
    },
  }
}

-- region keybindings
-- copy current file path
lvim.builtin.which_key.mappings["y"] = {
  name = "Copy",
  f = {
    "<cmd>let @+=expand('%')<CR>",
    "Copy current file path",
  }
}
lvim.keys.normal_mode["<S-u>"] = ":redo<CR>"
-- endregion

-- region Copilot
local ok, copilot = pcall(require, "copilot")
if not ok then
  return
end

copilot.setup {
  suggestion = {
    keymap = {
      accept = "<c-l>",
      next = "<c-j>",
      prev = "<c-k>",
      dismiss = "<c-h>"
    },
  },
}

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<c-s>", "<cmd>lua require('copilot.suggestion').toggle_auto_trigger()<CR>", opts)
-- endregion

-- region folding powered by treesitter
-- https://github.com/nvim-treesitter/nvim-treesitter#folding
-- look for foldenable: https://github.com/neovim/neovim/blob/master/src/nvim/options.lua
-- Vim cheatsheet, look for folds keys: https://devhints.io/vim
vim.opt.foldmethod = "expr"                     -- default is "normal"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- default is ""
vim.opt.foldenable = false                      -- if this option is true and fold method option is other than normal, every time a document is opened everything will be folded.
-- endregion

-- region conform
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})
-- endregion

-- region auto commands
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*/mako/config",
  callback = function()
    vim.cmd("silent! !makoctl reload")
  end,
})
-- endregion
