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

local unpack = table.unpack or unpack

local name_start_char = [[
":"
[A-Z]
"_"
[a-z]
[#xC0-#xD6]
[#xD8-#xF6]
[#xF8-#x2FF]
[#x370-#x37D]
[#x37F-#x1FFF]
[#x200C-#x200D]
[#x2070-#x218F]
[#x2C00-#x2FEF]
[#x3001-#xD7FF]
[#xF900-#xFDCF]
[#xFDF0-#xFFFD]
[#x10000-#xEFFFF]
]]

local name_char = name_start_char .. [[
"-"
"."
[0-9]
#xB7
[#x0300-#x036F]
[#x203F-#x2040]
]]

local function make_code(tree, code, i, depth)
  local u = tree[i]
  local j = i * 2
  local k = j + 1
  local v = tree[j]
  local w = tree[k]

  local indent = ("  "):rep(depth)
  local depth = depth + 1

  if type(w) == "number" then
    code[#code + 1] = indent .. ("if c < %d then\n"):format(u)
    make_code(tree, code, j, depth)
    code[#code + 1] = indent .. "else\n"
    make_code(tree, code, k, depth)
    code[#code + 1] = indent .. "end\n"
  elseif type(v) == "number" then
    code[#code + 1] = indent .. ("if c < %d then\n"):format(u)
    make_code(tree, code, j, depth)
    code[#code + 1] = indent .. ("else return %s end\n"):format(w)
  else
    code[#code + 1] = indent .. ("if c < %d then return %s else return %s end\n"):format(u, v, w)
  end
end

local function process(source, code_filename, test_filename)
  local flat = {}

  for i = 0, 0x10FFFF do
    flat[i] = false
  end

  local out = assert(io.open(test_filename, "w"))

  for line in source:gmatch("[^\n]+") do
    local a = line:match("^\"(.)\"$")
    local first, last
    if a then
      first = string.byte(a)
    else
      local a = line:match("^#x(%x+)$")
      if a then
        first = tonumber(a, 16)
      else
        local a, b = line:match("^%[(.)%-(.)%]")
        if a then
          first = string.byte(a)
          last = string.byte(b)
        else
          local a, b = assert(line:match("^%[#x(%x+)%-#x(%x+)%]$"))
          first = tonumber(a, 16)
          last = tonumber(b, 16)
        end
      end
    end
    if not last then
      last = first
    end

    for i = first, last do
      flat[i] = true
    end

    out:write(("%d\t%d\n"):format(first, last))
  end

  out:close()

  local ranges = {}
  local n = 0
  local first = 0
  local value = flat[0]
  for i = 1, 0x10FFFF do
    local v = flat[i]
    if value ~= v then
      n = n + 1
      ranges[n] = { first = first, value = value }
      first = i
      value = v
    end
  end
  n = n + 1
  ranges[n] = { first = first, value = value }

  local m = #ranges - 1
  local n = math.ceil(math.log(m) / math.log(2)) - 1

  local indice = {}
  for i = 1, m do
    indice[i] = i
  end

  local tree = {}
  for i = n, 0, -1 do
    local j = 2^i
    local k = 1
    local index = indice[k]
    while index and j <= m do
      tree[j] = ranges[index + 1].first
      table.remove(indice, k)
      j = j + 1
      k = k + 1
      index = indice[k]
    end
  end

  for i = 1, #ranges do
    local range = ranges[i]
    local first = range.first
    local value = range.value
    local j = 1
    repeat
      if first < tree[j] then
        j = j * 2
      else
        j = j * 2 + 1
      end
    until type(tree[j]) ~= "number"
    tree[j] = value
  end

  local code = {
    "return function (c)\n";
  }
  make_code(tree, code, 1, 1)
  code[#code + 1] = "end\n"

  local out = assert(io.open(code_filename, "w"))
  out:write(unpack(code))
  out:close()
end

process(
    name_start_char,
    "dromozoa/dom/name_start_char.lua",
    "test/test_name_start_char.txt")
process(
    name_char,
    "dromozoa/dom/name_char.lua",
    "test/test_name_char.txt")
