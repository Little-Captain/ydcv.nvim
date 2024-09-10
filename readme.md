
## 安装

### Lazy

```lua
{
  "Little-Captain/ydcv.nvim",
  dependencies = {
    'MunifTanjim/nui.nvim'
  },
  config = function()
    map('n', '<leader>k', function()
      local cw = vim.fn.expand '<cword>'
      local result = require('ydcv').ydcv(cw)
      local splited_result = vim.fn.split(result, '\n')
      require('ydcv').pop(splited_result)
    end, ext_opts())
  end,
}
```
