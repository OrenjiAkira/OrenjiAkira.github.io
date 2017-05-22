
local main_dict = require 'metainfo'

local function applytheme(str, dict)
  local out = str:gsub("[$][{].-[}]", function(expr)
    local var = expr:match("[{](.-)[}]")
    print(var, main_dict[var])
    return main_dict[var] or dict[var]
  end)
  -- print("applied theme", out)
  return out
end

return function (str)
  local header = str:match("[-][-][-][\n](.-)[\n][-][-][-]")
  local content = str:match("[-][-][-][\n].-[\n][-][-][-]\n(.*)")
  local dict = {}
  for key in header:gmatch("(%w+):") do
    local value = header:match(key .. ":%s*(%w+%s*%w+)%s*")
    dict[key] = value
  end
  dict.page_title = dict.title or "Page Title"
  dict.title = nil
  dict.page_content = require '_deployment.sugar' (applytheme(content, dict))
  dict.__index = dict
  return dict
end
