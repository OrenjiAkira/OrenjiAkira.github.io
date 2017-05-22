
local source = {...}
local template = "_source/template/main.lhtml"
local site_vars = require '_deployment.site_vars'

site_vars.init()

-- read file, apply theme, do stuff
for _,filepath in ipairs(source) do
  print()
  print("READING: " .. filepath)
  print()
  local file, e = io.open(filepath, "r")
  local fileinfo = file:read("*a")
  local page = require '_deployment/pageinfo' (fileinfo)
  file:close()

  print("Getting writing target...")
  local targetpath = "site/"
  local target = filepath:match(".-/pages/(.*)[.].*")
  if (target:match("index")) then
    targetpath = targetpath .. target .. ".html"
  else
    targetpath = targetpath .. target .. "/index.html"
  end

  print("Applying template...\n")
  file = io.open(template, "r")
  local str = file:read("*a")
  local out = site_vars.apply(str, page)
  file:close()

  print("WRITING: " .. targetpath)
  file, e = io.open(targetpath, "w")
  assert(file, e)
  file:write(out)
  file:close()
  print()
end
