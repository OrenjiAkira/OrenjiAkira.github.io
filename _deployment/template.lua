
local source = {...}
local dict = require 'metainfo'
local template = "_source/template.lhtml"

local function applytheme(str)
  local out = str:gsub("[$][{].-[}]", function(expr)
    local var = expr:match("[{](.-)[}]")
    print(var, dict[var])
    return dict[var]
  end)
  print("applied theme", out)
  return out
end

local function get_theme_part(part)
  local filepath = "_source/" .. part .. ".lhtml"
  local file = io.open(filepath, "r")
  local str = file:read("*a")
  local out = applytheme(str)
  file:close()
  dict[part .. "_template"] = out
end

-- load template files
get_theme_part("header")
get_theme_part("footer")

-- read file, apply theme, do stuff
for _,filepath in ipairs(source) do
  print("READING: " .. filepath)
  local file = io.open(filepath, "r")
  local fileinfo = file:read("*a")
  local page = require '_deployment/pageinfo' (fileinfo)
  setmetatable(dict, page)
  file:close()

  local file = io.open(template, "r")
  local str = file:read("*a")
  local out = applytheme(str)
  file:close()

  local targetpath = "site/"
  local target = filepath:match(".*/(.-)[.].*")
  if (target == "index") then
    targetpath = targetpath .. target .. ".html"
  else
    targetpath = targetpath .. target .. "/index.html"
  end
  print("WRITING: " .. targetpath)

  file = io.open(targetpath, "w")
  file:write(out)
  file:close()
end
