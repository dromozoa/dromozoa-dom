-- Copyright (C) 2017,2018 Tomoyuki Fujimori <moyu@dromozoa.com>
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

local super = color4
local class = {}
local metatable = {
  __index = class;
  ["dromozoa.dom.is_serializable"] = true;
}

function metatable:__tostring()
  local r = self[1] * 255
  local g = self[2] * 255
  local b = self[3] * 255
  local a = self[4]
  if r % 1 == 0 and g % 1 == 0 and b % 1 == 0 then
    if a == 1 then
      if r % 17 == 0 and g % 17 == 0 and b % 17 == 0 then
        return ("#%01X%01X%01X"):format(r / 17, g / 17, b / 17)
      else
        return ("#%02X%02X%02X"):format(r, g, b)
      end
    else
      return ("rgba(%d,%d,%d,%.17g)"):format(r, g, b, a)
    end
  else
    local r = self[1] * 100
    local g = self[2] * 100
    local b = self[3] * 100
    if a == 1 then
      return ("rgb(%.17g%%,%.17g%%,%.17g%%)"):format(r, g, b)
    else
      return ("rgba(%.17g%%,%.17g%%,%.17g%%,%.17g)"):format(r, g, b, a)
    end
  end
end

return setmetatable(class, {
  __index = super;
  __call = function (_, ...)
    return setmetatable(class.set({}, ...), metatable)
  end;
})
