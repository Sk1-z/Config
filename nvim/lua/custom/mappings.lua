local M = {}

M.general = {
  n = {
    ["<C-p>"] = { "<cmd> Telescope<CR>", "telescope" },
    ["<C-.>"] = { "<cmd> ChatGPT<CR>", "chatGPT" },
    ["<C-,>"] = { "<cmd> TroubleToggle<CR>", "trouble" },
    ["<C-'>"] = { "<cmd> Glow<CR>", "glow" },
  }
}

return M
