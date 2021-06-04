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

return utils
