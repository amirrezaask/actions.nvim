Actions = nil

local actions = {}
actions.__index = actions
actions.__newindex = function(_, k, v)
  Actions[k] = v
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
    string.format(":lua Actions:exec(vim.api.nvim_get_current_buf(), '%s')<CR>", name),
  {noremap=true})
end

function actions:set_mappings()
  for k, n in pairs(self.mappings) do
    map(k, n)
  end
end

function actions:setup(opts)
  Actions = setmetatable(opts, actions)
  Actions:set_mappings()
  return Actions
end

function actions:exec(bufnr, name)
  for _, obj in ipairs(Actions) do
    if obj.predicate and obj.actions and obj.predicate(bufnr) and obj.actions[name] then
      obj.actions[name](bufnr)
      return
    end
  end
end

return setmetatable({}, {
  __index = function(_, k)
    if Actions ~= nil then return Actions[k] end
    return actions[k]
  end
})
