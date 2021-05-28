# actions.nvim
In all IDEs out there ( for example Jetbrains Intelij,... ) there is a consistent interface for doing same action for different languages, for example the green play button always runs the project no matter what is the language or the framework.

actions.nvim brings this idea to neovim space, providing a simple API to define actions for filetypes or even define actions per project.

## Action Filters
Action Filters are the way we choose what function to call for a keymap.
Ordered by priority of selection:
- Projects
- Filetypes

## Usage
```lua
require('actions'):setup {
  mappings = {
    ['n ,b'] = 'build'
    ['n ,r'] = 'run'
  },
  projects = {
    ['~/src/github.com/amirrezaask/worker'] = {
      build = function(bufnr)
        print("project worker build command")
      end
    }
  },
  filetypes = {
    lua = {
      build = function(bufnr)
        -- This function runs when build keymap is pressed and we are in a lua file
        print('lua build command')
      end,
      run = function(bufnr)
        vim.cmd(string.format("luafile %s", vim.api.nvim_buf_get_name(bufnr)))
      end
    },
    go = {
      build = function(bufnr)
        -- This function runs when build keymap is pressed and we are in a go file
        print('go build command')
      end
    }
  }
}
```
