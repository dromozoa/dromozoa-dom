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

-- a:to_string()
local function to_string(a)
  local x = a[1]
  local y = a[2]
  local z = a[3]
  local w = a[4]

  if w == 255 then
    if x % 17 == 0 and y % 17 == 0 and z % 17 == 0 then
      return ("#%01X%01X%01X"):format(x / 17, y / 17, z / 17)
    else
      return ("#%02X%02X%02X"):format(x, y, z)
    end
  else
    return ("rgba(%d,%d,%d,%.17g)"):format(x, y, z, w / 255)
  end
end

local function check_component(v, k)
  local t = type(v)
  if t ~= "number" then
    if t == "string" then
      v = tonumber(v)
      if not v then
        error("bad component " .. k .. " (number expected, got " .. t .. ")")
      end
    else
      error("bad component " .. k .. " (number expected, got " .. t .. ")")
    end
  end
  if v < 0 or 255 < v then
    error("bad component " .. k .. " (out of range)")
  end
  return v
end

local function check_integer_component(v, k)
  v = check_component(v, k)
  if v % 1 ~= 0 then
    error("bad component " .. k .. " (number has no integer representation)")
  end
  return v
end

local super = color4
local class = {
  is_color4b = true;
  to_string = to_string;
}
local metatable = {
  __index = class;
  __tostring = to_string;
  ["dromozoa.dom.is_serializable"] = true;
}

-- a:set(number b, number y, number z, number w)
-- a:set(number b, number y, number z)
-- a:set(tuple3 b)
-- a:set(tuple4 b)
-- a:set()
function class.set(a, b, y, z, w)
  if b then
    if y then
      a[1] = check_integer_component(b, "x")
      a[2] = check_integer_component(y, "y")
      a[3] = check_integer_component(z, "z")
      a[4] = check_component(w or 255, "w")
    else
      a[1] = check_integer_component(b[1], "x")
      a[2] = check_integer_component(b[2], "y")
      a[3] = check_integer_component(b[3], "z")
      a[4] = check_component(b[4] or 255, "w")
    end
  else
    a[1] = 0
    a[2] = 0
    a[3] = 0
    a[4] = 0
  end
  return a
end

return setmetatable(class, {
  __index = super;
  __call = function (_, ...)
    return setmetatable(class.set({}, ...), metatable)
  end;
})
