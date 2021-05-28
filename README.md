# actions.nvim
In all IDEs out there ( for example Jetbrains Intelij,... ) there is a consistent interface for doing same action for different languages, for example the green play button always runs the project no matter what is the language or the framework.

Actions.nvim brings this idea in neovim space, you can define actions for different languages and bind them to the same keymap.

## Usage
```lua
require('actions'):setup {
  mappings = {
    ['n ,b'] = 'build'
  },
  filetypes = {
    lua = {
      build = function(bufnr)
        -- This function runs when build keymap is pressed and we are in a lua file
        print('lua build command')
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
