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
  _"defs" {
    _"filter" {
      id = "f";
      _"feColorMatrix" {
        ["in"] = "SourceGraphic";
        result = "x";
        type = "matrix";
        values = space_separated {
          0, 0, 0, 0, 1,
          0, 0, 0, 0, 0,
          0, 0, 0, 0, 0,
          0, 0, 0, 1, 0,
        };
      };
      _"feMorphology" {
        ["in"] = "x";
        result = "y";
        operator = "dilate";
        radius = 4;
      };
      _"feBlend" {
        ["in"] = "SourceGraphic";
        ["in2"] = "y";
        mode = "normal";
      };
    };
    _"filter" {
      id = "f2";
      _"feColorMatrix" {
        ["in"] = "SourceGraphic";
        result = "a";
        type = "matrix";
        values = space_separated {
          0, 0, 0, 0, 1,
          0, 0, 0, 0, 0,
          0, 0, 0, 0, 0,
          0, 0, 0, 1, 0,
        };
      };
      _"feMorphology" {
        ["in"] = "a";
        result = "b";
        operator = "dilate";
        radius = 1;
      };
      _"feMorphology" {
        ["in"] = "b";
        result = "c";
        operator = "dilate";
        radius = 1;
      };
      _"feMorphology" {
        ["in"] = "c";
        result = "d";
        operator = "dilate";
        radius = 1;
      };
      _"feMorphology" {
        ["in"] = "d";
        result = "e";
        operator = "dilate";
        radius = 1;
      };
      _"feBlend" {
        ["in"] = "SourceGraphic";
        ["in2"] = "e";
        mode = "normal";
      };
    };
    _"filter" {
      id = "f3";
      _"feGaussianBlur" {
        ["in"] = "SourceGraphic";
        result = "a";
        stdDeviation = 4;
      };
      _"feColorMatrix" {
        ["in"] = "a";
        result = "b";
        type = "matrix";
        values = space_separated {
          0, 0, 0, 0, 1,
          0, 0, 0, 0, 0,
          0, 0, 0, 0, 0,
          0, 0, 0, 8, -1,
        };
      };
      _"feBlend" {
        ["in"] = "SourceGraphic";
        ["in2"] = "b";
        mode = "normal";
      };
    };
  };
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
      fill = color4d(1, 0, 0, 0.5);
      stroke = color4d(1, 0, 0, 0.5);
      ["stroke-width"] = "8px";
      "墾田永年私財法";
    };
  };
  _"g" {
    transform = "translate(50, 400)";
    style = "font-size: 200px";
    _"text" {
      fill = color4d(1, 0, 0, 0.5);
      stroke = "none";
      "墾田永年私財法";
    };
  };
  _"g" {
    transform = "translate(50, 600)";
    style = "font-size: 200px";
    _"text" {
      fill = color4d(1, 1, 1, 1);
      stroke = "none";
      filter = "url(#f)";
      "墾田永年私財法";
    };
  };
  _"g" {
    transform = "translate(50, 800)";
    style = "font-size: 200px";
    _"text" {
      fill = color4d(1, 1, 1, 1);
      stroke = "none";
      filter = "url(#f2)";
      "墾田永年私財法";
    };
  };
  _"g" {
    transform = "translate(50, 1000)";
    style = "font-size: 200px";
    _"text" {
      fill = color4d(1, 1, 1, 1);
      stroke = "none";
      filter = "url(#f3)";
      "墾田永年私財法";
    };
  };
  _"g" {
    transform = "translate(50, 1200)";
    style = "font-size: 200px";
    _"text" {
      fill = color4d(1, 0, 0, 1);
      stroke = color4d(1, 0, 0, 1);
      ["stroke-width"] = 8;
      "墾田永年私財法";
    };
    _"text" {
      fill = color4d(1, 1, 1, 1);
      stroke = "none";
      "墾田永年私財法";
    };
  };
})
doc:serialize(io.stdout)
io.write "\n"
