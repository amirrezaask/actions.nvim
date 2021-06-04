# actions.nvim
In all IDEs out there ( for example Jetbrains Intelij,... ) there is a consistent interface for doing same action for different languages, for example the green play button always runs the project no matter what is the language or the framework.

actions.nvim brings this idea to neovim space, providing a simple API to define actions for a prediacte.

## Terminology
- Actions: are things you want to do that have same name but differ for each predicate.
- Predicates: are functions that help us choose the right action for the buffer.

## Usage
```lua
actions:setup {
  mappings = {
    ['n ,ab'] = 'build',
    ['n ,at'] = 'test_all',
    ['n ,tt'] = 'test_this',
    ['n ,ar'] = 'run',
  },
  {
    predicate = utils.make_language_predicate('lua'),
    actions = {
      run = function(bufnr)
        vim.cmd(string.format([[luafile %s]], vim.api.nvim_buf_get_name(bufnr)))
      end,
    },
  },
  {
    predicate = utils.make_language_predicate('go'),
    actions = {
      build = function(_)
        print('go build command')
      end,
      test_all = function(_)
        print('go test all command')
      end,
      test_this = function(_)
        print('go test this command')
      end
    }
  },
}

```
