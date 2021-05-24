# actions.nvim
define same behaviour across different file types.


## Usage
```lua
require('actions'):setup {
  mappings = {
    ['n ,b'] = 'build'
  },
  filetypes = {
    lua = {
      build = function(bufnr)
        print('lua build command')
      end
    },
    go = {
      build = function(bufnr)
        print('go build command')
      end
    }
  }
}
```
