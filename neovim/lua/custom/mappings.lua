local M = {}

M.general = {
  n = {
    ["<C-p>"] = { "<cmd> Telescope<CR>", "telescope" },
    ["<C-e>"] = { "<cmd> TroubleToggle<CR>", "trouble" },
    ["<leader>M"] = { "<cmd> MarkdownPreview<CR>", "Preview Markdown" },
    ["<leader>L"] = { "<cmd> VimtexCompile<CR>", "Preview Latex" },
  }
}

return M
