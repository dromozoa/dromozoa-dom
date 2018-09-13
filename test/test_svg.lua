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

local dom = require "dromozoa.dom"

local color4d = require "dromozoa.css.color4d"
local path_data = require "dromozoa.svg.path_data"

local _ = dom.element

local s = 1 / math.sqrt(10)
local c = color4d(1, 0, 0, 0.25)

local doc = dom.xml_document(_"svg" {
  version = "1.1";
  xmlns = "http://www.w3.org/2000/svg";
  _"defs" {
    _"marker" {
      id = "triangle";
      viewBox = dom.space_separated { 0, 0, 2, 2 };
      refX = 0;
      refY = 1;
      markerWidth = 3;
      markerHeight = 3;
      orient = "auto";
      _"path" {
        d = path_data():M(0,0):L(0,2):L(2,1):Z();
        fill = color4d(1, 0, 0, 0.25);
        stroke = "none";
      };
    };
  };
  _"circle" {
    cx = 100;
    cy = 100;
    r = 100;
    fill = "#fcf";
    stroke = "none";
  };
  _"path" {
    d = path_data():M(100, 100):L(150, 250):L(350, 250);
    fill = "none";
    stroke = color4d(0, 1, 0, 0.25);
    ["stroke-width"] = 5;
  };
  _"path" {
    d = path_data():M(350, 250):S(150, 250, 100 + 15 * s, 100 + 15 * 3 * s);
    fill = "none";
    stroke = color4d(1, 0, 0, 0.25);
    ["stroke-width"] = 5;
    ["marker-end"] = "url(#triangle)";
  };
  _"path" {
    d = path_data():M(350, 250):S(150, 250, 100 + 115 * s, 100 + 115 * 3 * s);
    fill = "none";
    stroke = color4d(1, 0, 0, 0.25);
    ["stroke-width"] = 5;
    ["marker-end"] = "url(#triangle)";
  };
  _"path" {
    d = path_data():M(350, 250):L(50 + 50 / s, 250):S(150, 250, 100 + 115 * s, 100 + 115 * 3 * s);
    fill = "none";
    stroke = color4d(1, 0, 0, 0.25);
    ["stroke-width"] = 5;
    ["marker-end"] = "url(#triangle)";
  };
})

local out = assert(io.open("test.svg", "w"))
doc:serialize(out)
out:write "\n"
out:close()
