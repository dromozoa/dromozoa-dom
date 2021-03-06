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

local comma_separated = require "dromozoa.dom.comma_separated"
local space_separated = require "dromozoa.dom.space_separated"

local verbose = os.getenv "VERBOSE" == "1"

local function check(source, expect)
  local result = tostring(source)
  if verbose then
    print(result)
  end
  assert(result == expect)
end

check(comma_separated {}, "")
check(comma_separated { 42, "foo" }, "42,foo")
check(space_separated {}, "")
check(space_separated { 42, "foo" }, "42 foo")
