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

local element = require "dromozoa.dom.element"
local space_separated = require "dromozoa.dom.space_separated"
local xml_document = require "dromozoa.dom.xml_document"
local color4d = require "dromozoa.css.color4d"

local _ = element

local doc = xml_document(_"svg" {
  version = "1.1";
  xmlns = "http://www.w3.org/2000/svg";
  width = 1920;
  height = 1920;
  _"rect" {
    x = 0;
    y = 0;
    width = 1920;
    height = 1920;
    fill = color4d(0.8, 0.8, 0.8, 1);
    stroke = "none";
  };
  _"g" {
    transform = "translate(50, 200)";
    style = "font-size: 200px";
    _"text" {
      -- x = 0;
      -- y = 0;
      fill = color4d(0, 0, 0, 0.5);
      stroke = "none";
      -- textLength = "600";
      textLength = "300";
      lengthAdjust = "spacingAndGlyphs";
      -- style = "shape-rendering: geometricPrecision; text-rendering: geometricPrecision";
      -- "Shrunk using spacing and glyphs.";
      -- _"tspan" {
        "墾田永年私財法";
        -- "Shrunk using spacing and glyphs.";
      -- };
    };
  };
})
doc:serialize(io.stdout)
io.write("\n")
