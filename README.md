# actions.nvim
In all IDEs out there ( for example Jetbrains Intelij,... ) there is a consistent interface for doing same action for different languages, for example the green play button always runs the project no matter what is the language or the framework.

Actions.nvim brings this idea in neovim space, you can define actions for different languages and bind them to the same keymap.

## Action Filters
Action Filters are the way we choose what function to call for a keymap.
Ordered by priority:
- Projects
- Filetypes
Basically we check if there is any action for the current project ( your cwd ) and if nothing found then we check for the filetype.

## Usage
```lua
require('actions'):setup {
  mappings = {
    ['n ,b'] = 'build'
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
