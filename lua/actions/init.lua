-- on BufEnter replace current file type configuration
-- {
-- filetype(key) = {
--  action_name = function_callback
-- }
_G.__CurrentActions = {}

local action = {}
action.__index = action

local function map(key, name)
  local mode = ''
  local keyseq = key
  local splitted = vim.split(key, ' ')
  if #splitted > 1 then
    mode = splitted[1]
    keyseq = splitted[2]
  end
  vim.api.nvim_set_keymap(mode, 
    vim.api.nvim_replace_termcodes(keyseq, true, true, true),
    string.format(":lua __CurrentActions:exec(vim.api.nvim_get_current_buf(), '%s')<CR>", name),
  {noremap=true})
end

function action:set_mappings()
  for k, n in pairs(self.mappings) do
    map(k, n)
  end
end

function action:setup(opts)
  _G.__CurrentActions = setmetatable(opts, action)
  __CurrentActions:set_mappings()
  return _G.__CurrentActions
end

function action:exec(bufnr, name)
  local filetype = vim.api.nvim_buf_get_option(bufnr, 'filetype')
  local ft_actions = _G.__CurrentActions['filetypes'][filetype]
  if ft_actions then
    local ft_action = ft_actions[name]
    if ft_action then
      ft_action(bufnr)
    end
  end
end

return action
