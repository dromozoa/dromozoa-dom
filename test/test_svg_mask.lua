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
local element = require "dromozoa.dom.element"
local space_separated = require "dromozoa.dom.space_separated"
local xml_document = require "dromozoa.dom.xml_document"
local color4d = require "dromozoa.css.color4d"
local path_data = require "dromozoa.svg.path_data"

local _ = element

local doc = xml_document(_"svg" {
  version = "1.1";
  xmlns = "http://www.w3.org/2000/svg";
  ["xmlns:xlink"] ="http://www.w3.org/1999/xlink";

  _"defs" {
    _"clipPath" {
      id = "clip";
      _"text" {
        x = 20;
        y = 200;
        ["font-size"] = "200px";
        "墾田永年私財法";
      };
    };

    _"mask" {
      id = "mask";
      _"g" {
        _"rect" {
          x = 50;
          y = 50;
          width = 500;
          height = 500;
          fill = "white";
        };
        _"circle" {
          cx = 300;
          cy = 200;
          r = 100;
        };
        _"text" {
          x = 50;
          y = 450;
          ["font-size"] = "200px";
          "墾田永年私財法";
        };
      };
    };
  };

  _"rect" {
    x = 0;
    y = 0;
    width = 600;
    height = 600;
    fill = "#f00";
  };

  _"image" {
    x = 0;
    y = 0;
    width = 600;
    height = 600;
    ["xlink:href"] = "http://www.cs.cmu.edu/~chuck/lennapg/len_std.jpg";
    ["mask"] = "url(#mask)";
  };
})
doc:serialize(io.stdout)
io.write("\n")
