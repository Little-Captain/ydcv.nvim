local M = {}

function M.query(word)
  return vim.fn.system("/home/lc/Code/dotfiles/bin/dict '" .. word .. "'")
end

function M.pop(contents)
  local Popup = require 'nui.popup'
  local event = require('nui.utils.autocmd').event
  local popui = Popup {
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
  popui:mount()
  popui:on(event.BufLeave, function()
    popui:unmount()
  end)
  vim.api.nvim_buf_set_lines(popui.bufnr, 0, -1, false, contents)
end

function M.ydcv(word)
  if word == '' then
    return
  end
  M.pop(vim.fn.split(M.query(word), '\n'))
end

function M.input(callback)
  local Input = require 'nui.input'
  local event = require('nui.utils.autocmd').event

  local input = Input({
    position = '50%',
    size = { width = 30 },
    border = {
      style = 'single',
      text = {
        top = '[Please input word]',
        top_align = 'center',
      },
    },
    win_options = { winhighlight = 'Normal:Normal,FloatBorder:Normal' },
  }, {
    prompt = '> ',
    default_value = '',
    on_submit = function(value)
      callback(value or '')
    end,
  })

  input:mount()
  input:on(event.BufLeave, function()
    input:unmount()
  end)
end

return M
