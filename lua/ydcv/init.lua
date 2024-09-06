local M = {}

function M.get_visual_selection()
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

function M.ydcv()
  -- 获取当前光标下的单词或选中的文本
  local m = vim.api.nvim_get_mode()
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

  -- 创建临时 buffer
  -- 设置属性
  -- buftype: nofile
  -- bufhidden: wipe

  -- 执行系统命令并将输出放入临时 buffer

  -- 新建浮动窗口并加载临时 buffer

  -- 关闭 number 和 foldcolumn

  -- 设置缓冲区局部映射：当按下两次 ESC 时关闭窗口并删除缓冲区
end

return M
