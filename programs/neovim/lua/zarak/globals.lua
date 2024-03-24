-- Print table values instead of references
P = function(v)
  print(vim.inspect(v))
  return v
end
