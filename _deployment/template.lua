
local source = {...}
local dict = require 'metainfo'
local template = "_source/template.lhtml"

local function applytheme(str)
  local out = str:gsub("[$][{].-[}]", function(expr)
    local var = expr:match("[{](.-)[}]")
    return dict[var]
  end)
  return out
end

-- read file, apply theme, do stuff
for _,filepath in ipairs(source) do
  print("READING: " .. filepath)
  local fileinfo = io.open(filepath, "r"):read("*a")
  local page = require '_deployment/pageinfo' (fileinfo)
  setmetatable(dict, page)
  io.input():close()

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
