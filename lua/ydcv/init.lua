local M = {}

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
