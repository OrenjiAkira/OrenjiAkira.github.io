
local main_dict = require 'metainfo'

local function apply_vars(str, dict)
  local out = str:gsub("[$][{].-[}]", function(expr)
    local var = expr:match("[{](.-)[}]")
    return main_dict[var] or dict and dict[var]
  end)
  return out
end

local function get_theme_part(part)
  local filepath = "_source/template/" .. part .. ".lhtml"
  local file = io.open(filepath, "r")
  local str = file:read("*a")
  local out = apply_vars(str)
  file:close()
  main_dict[part .. "_template"] = out
end

-- load template files
local function init_template ()
  get_theme_part("header")
  get_theme_part("footer")
end

return {
  init = init_template,
  apply = apply_vars,
}
