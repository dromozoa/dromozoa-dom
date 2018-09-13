-- Copyright (C) 2018 Tomoyuki Fujimori <moyu@dromozoa.com>
--
-- This file is part of dromozoa-dom.
--
-- dromozoa-dom is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- dromozoa-dom is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with dromozoa-dom.  If not, see <http://www.gnu.org/licenses/>.

local color4 = require "dromozoa.vecmath.color4"

local function to_string(a)
  local x = a[1]
  local y = a[2]
  local z = a[3]
  local w = a[4]

  local X = x * 255
  if X % 1 == 0 then
    local Y = y * 255
    if Y % 1 == 0 then
      local Z = z * 255
      if Z % 1 == 0 then
        if w == 1 then
          if X % 17 == 0 and Y % 17 == 0 and Z % 17 == 0 then
            return ("#%01X%01X%01X"):format(X / 17, Y / 17, Z / 17)
          else
            return ("#%02X%02X%02X"):format(X, Y, Z)
          end
        else
          return ("rgba(%d,%d,%d,%.17g"):format(X, Y, Z, w)
        end
      end
    end
  end

  if w == 1 then
    return ("rgb(%.17g%%,%.17g%%,%.17g%%)"):format(x * 100, y * 100, z * 100)
  else
    return ("rgba(%.17g%%,%.17g%%,%.17g%%,%.17g)"):format(x * 100, y * 100, z * 100, w)
  end
end

local super = color4
local class = {
  is_color4f = true;
  to_string = to_string;
}
local metatable = {
  __index = class;
  __tostring = to_string;
  ["dromozoa.dom.is_serializable"] = true;
}

return setmetatable(class, {
  __index = super;
  __call = function (_, ...)
    return setmetatable(class.set({}, ...), metatable)
  end;
})
