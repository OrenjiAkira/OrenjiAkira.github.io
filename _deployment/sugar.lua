
return function(source)
  local out = require 'markdown' (source)

  -- add image link
  out = out:gsub("[!][[](.-)[]][(](.-)[)]", function(alt, src)
    return "<img alt='" .. alt .."' title='" .. alt ..
    "' src='" .. src .. "' />"
  end)

  -- class divs
  out = out:gsub("[{](.-)[}]%s*(.-)\n%s*\n", function(classes, text)
    return "<p class='" .. classes .. "'>" .. text .. "</p>"
  end)

  out = out:gsub("%%(.-)%%%s*==(.-)==", function(classes, text)
    return "<div class='" .. classes .. "'>" .. text .. "</div>"
  end)

  print(out)
  return out
end
