local M = {}

--[[
-- 这个函数在这里定义并不能很好工作
-- 但是在 keymap.lua 中定义，就能很好工作
-- 具体原因还不清楚
--
  local ms = { ['v'] = true, ['V'] = true, ['^V'] = true }
  local cw = ''
  if m.mode == 'n' then
    print(m.mode)
    cw = vim.fn.expand '<cword>'
  elseif ms[m.mode] then
    print(m.mode)
    cw = M.get_visual_selection()
  end
  return cw
local function get_visual_selection()
  -- 获取当前的选区
  local _, start_row, start_col, _ = unpack(vim.fn.getpos "'<")
  local _, end_row, end_col, _ = unpack(vim.fn.getpos "'>")

  -- 如果选中的是单行
  if start_row == end_row then
    return string.sub(vim.fn.getline(start_row), start_col, end_col)
  end

  -- 如果选中的是多行
  local lines = vim.fn.getline(start_row, end_row)
  lines[1] = string.sub(lines[1], start_col)
  lines[#lines] = string.sub(lines[#lines], 1, end_col)
  return table.concat(lines, '\n')
end
--]]

function M.ydcv(word)
  if vim.api.nvim_get_mode().mode ~= 'n' then
    return ''
  end
  return vim.fn.system("/home/lc/Code/dotfiles/bin/dict '" .. word .. "'")
end

function M.pop(replacement)
  if replacement == '' then
    return
  end
  local Popup = require 'nui.popup'
  local event = require('nui.utils.autocmd').event
  M.popui = Popup {
    enter = true,
    focusable = true,
    border = {
      style = 'rounded',
    },
    position = '50%',
    size = {
      width = '80%',
      height = '60%',
    },
  }
  M.popui:mount()
  M.popui:on(event.BufLeave, function()
    M.popui:unmount()
  end)
  vim.api.nvim_buf_set_lines(M.popui.bufnr, 0, -1, false, replacement)
end

return M
