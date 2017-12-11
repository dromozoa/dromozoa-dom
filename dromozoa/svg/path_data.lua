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

function class:M(x, y)
  self[#self + 1] = { "M", x, y }
  return self
end

function class:Z()
  self[#self + 1] = { "Z" }
  return self
end

function class:L(x, y)
  self[#self + 1] = { "L", x, y }
  return self
end

function class:H(x)
  self[#self + 1] = { "H", x }
  return self
end

function class:V(y)
  self[#self + 1] = { "V", y }
  return self
end

function class:C(x1, y1, x2, y2, x, y)
  self[#self + 1] = { "C", x1, y1, x2, y2, x, y }
  return self
end

function class:S(x2, y2, x, y)
  self[#self + 1] = { "S", x2, y2, x, y }
  return self
end

function class:Q(x1, y1, x, y)
  self[#self + 1] = { "Q", x1, y1, x, y }
  return self
end

function class:T(x, y)
  self[#self + 1] = { "T", x, y }
  return self
end

function class:A(rx, ry, r_axis_rotation, large_arc_flag, sweep_flag, x, y)
  self[#self + 1] = { "A", rx, ry, r_axis_rotation, large_arc_flag, sweep_flag, x, y }
  return self
end

function metatable:__tostring()
  local buffer = {}
  for i = 1, #self do
    local data = self[i]
    buffer[i] = data[1] .. table.concat(data, ",", 2)
  end
  return table.concat(buffer, " ")
end

return setmetatable(class, {
  __tostring = tostring;
  __call = function (_, name)
    return setmetatable({}, metatable)
  end;
})
