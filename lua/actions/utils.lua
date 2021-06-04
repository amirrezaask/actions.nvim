local utils = {}

function utils.make_language_predicate(lang)
  return function(bufnr)
    return vim.api.nvim_buf_get_option(bufnr, 'filetype') == lang
  end
end

function utils.make_path_predicate(path)
  return function(bufnr)
    return vim.fn.expand(vim.api.nvim_buf_get_name(bufnr)):find(vim.fn.expand(path)) ~= nil
  end
end

function utils.make_abs_path_predicate(path)
  return function(bufnr)
    return vim.fn.expand(vim.api.nvim_buf_get_name(bufnr)) == vim.fn.expand(path)
  end
end

function utils.compose(...)
  local ps = {...}
  return function(bufnr)
    local output = true
    for _, p in ipairs(ps) do
      output = output and p(bufnr)
    end
    return output
  end
end

return utils
