_G.__CurrentActions = nil

local actions = {}
actions.__index = actions
actions.__newindex = function(_, k, v)
  _G.__CurrentActions[k] = v
end

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

function actions:set_mappings()
  for k, n in pairs(self.mappings) do
    map(k, n)
  end
end

function actions:setup(opts)
  _G.__CurrentActions = setmetatable(opts, actions)
  __CurrentActions:set_mappings()
  return _G.__CurrentActions
end

function actions:exec(bufnr, name)
  local filetype = vim.api.nvim_buf_get_option(bufnr, 'filetype')
  local project_path = vim.fn.expand(vim.loop.cwd())
  local project_actions 
  if _G.__CurrentActions['projects'] then
    for p, as in pairs(_G.__CurrentActions['projects']) do 
      if vim.fn.expand(p) == project_path then
        project_actions = as 
      end
    end
  end
  local ft_actions = _G.__CurrentActions['filetypes'][filetype]
  if project_actions then
    if project_actions[name] then
      project_actions[name](bufnr)
      return
    end
  end
  if ft_actions then
    local ft_action = ft_actions[name]
    if ft_action then
      ft_action(bufnr)
    end
  end
end

return setmetatable({}, {
  __index = function(_, k)
    if _G.__CurrentActions ~= nil then return _G.__CurrentActions[k] end
    return actions[k]
  end
})
