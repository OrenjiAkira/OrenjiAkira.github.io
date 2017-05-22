
local source = io.read("*a")
local target = "site/style.css"
local output

print("\nMinifying CSS:")
output = source:gsub("/%*.-%*/", " ")
output = output:gsub("\n", " ")
output = output:gsub("%s(%s*)", " ")
print(output .. "\n")
print("CSS minified!\n")

local file = io.open(target, "w")
file:write(output)
file:close()
