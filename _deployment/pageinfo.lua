
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
  dict.page_content = content
  dict.__index = dict
  return dict
end
