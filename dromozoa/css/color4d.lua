-- Copyright (C) 2017 Tomoyuki Fujimori <moyu@dromozoa.com>
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

local class = {}
local metatable = {
  __index = class;
  ["dromozoa.dom.is_serializable"] = true;
}

function metatable:__tostring()
  local r = self[1]
  local g = self[2]
  local b = self[3]
  local a = self[4]

  local x = r * 255
  local y = g * 255
  local z = b * 255

  if a == 1 then
    local x = r * 255
    local y = g * 255
    local z = b * 255
    if x % 1 == 0 and y % 1 == 0 and z % 1 == 0 then
      if x % 17 == 0 and y % 17 == 0 and z % 17 == 0 then
        return ("#%01X%01X%01X"):format(x / 17, y / 17, z / 17)
      else
        return ("#%02X%02X%02X"):format(x, y, z)
      end
    else
      return ("rgb(%.17g%%,%.17g%%,%.17g%%)"):format(r * 100, g * 100, b * 100)
    end
  else
    if x % 1 == 0 and y % 1 == 0 and z % 1 == 0 then
      return ("rgba(%d,%d,%d,%.17g)"):format(x, y, z, a / 255)
    else
      return ("rgba(%.17g%%,%.17g%%,%.17g%%,%.17g)"):format(r * 100, g * 100, b * 100, a)
    end
  end
end

return setmetatable(class, {
  __call = function (_, r, g, b, a)
    if a == nil then
      a = 1
    end
    local self = { r, g, b, a }
    for i = 1, 4 do
      local v = self[i]
      local t = type(v)
      if t ~= "number" then
        if t == "string" then
          v = tonumber(v)
          if not v then
            error("bad argument #" .. i .. " (number expected, got " .. t .. ")")
          end
        else
          error("bad argument #" .. i .. " (number expected, got " .. t .. ")")
        end
      end
      if v < 0 or 1 < v then
        error("bad argument #" .. i .. " (out of range)")
      end
      self[i] = v
    end
    return setmetatable(self, metatable)
  end;
})
