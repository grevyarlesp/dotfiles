local M = {}

--- Bundle every configs|plugins we need for specific language
---@type table<string,boolean>
M.pack = {
  ai = vim.fn.has("wsl") == 0,
  cloud = true,
  common = true,
  csharp = true,
  go = true,
  cpp = true,
  lua = true,
  markdown = true,
  php = true,
  python = true,
  sql = true,
  tailwind = true,
  typescript = true,
}

--- Root patterns for auto detect and change root
---@type string[]
M.root_patterns = { ".git" }

return M
