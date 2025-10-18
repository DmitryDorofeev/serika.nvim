local palette = require("serika.palette")
local theme = require("serika.theme")

local M = {}

local defaults = {
  transparent = false,
}

local config = vim.deepcopy(defaults)

local function apply_terminal_palette(colors)
  local term = colors.terminal or {}

  vim.g.terminal_color_0 = term.black
  vim.g.terminal_color_1 = term.red
  vim.g.terminal_color_2 = term.green
  vim.g.terminal_color_3 = term.yellow
  vim.g.terminal_color_4 = term.blue
  vim.g.terminal_color_5 = term.magenta
  vim.g.terminal_color_6 = term.cyan
  vim.g.terminal_color_7 = term.white
  vim.g.terminal_color_8 = term.bright_black
  vim.g.terminal_color_9 = term.bright_red
  vim.g.terminal_color_10 = term.bright_green
  vim.g.terminal_color_11 = term.bright_yellow
  vim.g.terminal_color_12 = term.bright_blue
  vim.g.terminal_color_13 = term.bright_magenta
  vim.g.terminal_color_14 = term.bright_cyan
  vim.g.terminal_color_15 = term.bright_white
end

function M.load(opts)
  if vim.fn.has("termguicolors") == 1 then
    vim.o.termguicolors = true
  end

  if vim.g.colors_name then
    vim.cmd("hi clear")
  end

  if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
  end

  vim.o.background = "dark"
  vim.g.colors_name = "serika"

  local colors = palette
  local resolved_opts = vim.tbl_deep_extend("force", {}, config, opts or {})
  local highlights = theme.highlights(colors, resolved_opts)

  for group, spec in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, spec)
  end

  apply_terminal_palette(colors)
end

function M.setup(opts)
  config = vim.tbl_deep_extend("force", {}, defaults, opts or {})
end

function M.colors()
  return palette
end

function M.highlights(opts)
  local resolved = vim.tbl_deep_extend("force", {}, config, opts or {})
  return theme.highlights(palette, resolved)
end

return M
