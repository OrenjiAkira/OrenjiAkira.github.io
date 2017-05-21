
local target = io.read("*a")
local pageinfo = require '_deployment.pageinfo' (target)

print("PAGE INFO READ, PRINTING VALUES:")
for k,v in pairs(pageinfo) do print(k,v) end
