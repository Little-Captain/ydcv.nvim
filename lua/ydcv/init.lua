local M = {}

function M.ydcv()
  local m = vim.api.nvim_get_mode()
  local ms = { ['v'] = true, ['V'] = true, ['^V'] = true }
  local cw = ''
  print(m.mode)
  if m.mode == 'n' then
    cw = vim.fn.expand '<cword>'
  elseif ms[m.mode] then
    --[[
      [bufnum, lnum, col, off]
    --]]
    local s = vim.fn.getpos "'<"
    local e = vim.fn.getpos "'>"
    print(table.concat({ s[2], s[3], s[4], e[2], e[3], e[4] }, ', '))
    -- local lines = vim.api.nvim_buf_get_lines(0, s[1], e[1], true)
    -- cw = table.concat(lines, '\n')
    -- local selected_text = ''
    -- if s[2] == e[2] then -- 单行选中
    --   selected_text = lines[1]:sub(s[3], e[3])
    -- else -- 多行选中
    --   selected_text = lines[1]:sub(s[3], -1)
    --   for _, line in ipairs(lines) do
    --     if line ~= lines[1] and line ~= lines[#lines] then
    --       selected_text = selected_text .. line .. '\n'
    --     end
    --   end
    --   selected_text = selected_text .. lines[#lines]:sub(1, e[3])
    -- end
  end
  print(cw)

  --[[
local api = require'nvim_api'
-- 获取当前选中的文本
local function get_selected_text()
    -- 获取当前模式
    local mode = api.nvim_get_mode().mode

    -- 检查是否处于可视模式
    if mode:match'^v' then
        -- 获取可视模式下的选区范围
        local start = api.nvim_get_mark('<')
        local end_ = api.nvim_get_mark('>')
        local lines = api.nvim_buf_get_lines(0, start[2] - 1, end_[2], true)

        -- 根据选区的开始和结束位置拼接选中的文本
        local selected_text = ''
        if start[2] == end_[2] then -- 单行选中
            selected_text = lines[1]:sub(start[3], end_[3])
        else -- 多行选中
            selected_text = lines[1]:sub(start[3], -1)
            for _, line in ipairs(lines) do
                if line ~= lines[1] and line ~= lines[#lines] then
                    selected_text = selected_text .. line .. '\n'
                end
            end
            selected_text = selected_text .. lines[#lines]:sub(1, end_[3])
        end
        return selected_text
    else
        -- 如果不是可视模式，则获取光标下的单词
        local word = api.nvim_eval('expand("<cword>")')
        return word
    end
end

-- 示例调用
local selected_text = get_selected_text()
print(selected_text)
  --]]
  -- 获取当前光标下的单词或选择的单词

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
