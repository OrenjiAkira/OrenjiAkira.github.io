
local source = {...}
local dict = require 'metainfo'
local template = "_source/template/main.lhtml"

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
  local filepath = "_source/template/" .. part .. ".lhtml"
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
  print()
  print("READING: " .. filepath)
  print()
  print("open file (read)", filepath)
  local file, e = io.open(filepath, "r")
  local fileinfo = file:read("*a")
  local page = require '_deployment/pageinfo' (fileinfo)
  setmetatable(dict, page)
  file:close()
  print("close file")

  print("open file (read)", template)
  file = io.open(template, "r")
  local str = file:read("*a")
  local out = applytheme(str)
  file:close()
  print("close file")

  local targetpath = "site/"
  local target = filepath:match(".-/pages/(.*)[.].*")
  print("### TARGET FILE ###")
  print(target)
  print()
  if (target:match("index")) then
    targetpath = targetpath .. target .. ".html"
  else
    targetpath = targetpath .. target .. "/index.html"
  end
  print("WRITING: " .. targetpath)

  print("open file (write)", targetpath)
  file, e = io.open(targetpath, "w")
  assert(file, e)
  file:write(out)
  file:close()
  print("close file")
end
