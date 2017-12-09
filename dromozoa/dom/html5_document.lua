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

local serialize_html5 = require "dromozoa.dom.serialize_html5"

local class = {}
local metatable = { __index = class }

function class:serialize(out)
  out:write("<!DOCTYPE html>")
  serialize_html5(out, self.document_element)
end

return setmetatable(class, {
  __call = function (_, document_element)
    return setmetatable({ document_element = document_element }, metatable)
  end;
})
