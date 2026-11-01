--- @since 25.12.29
--- @diagnostic disable: undefined-global, undefined-field
--- @alias Mode Mode Comes from Yazi.
--- @alias Rect Rect Comes from Yazi.
--- @alias Paragraph Paragraph Comes from Yazi.
--- @alias Line Line Comes from Yazi.
--- @alias Span Span Comes from Yazi.
--- @alias Color Color Comes from Yazi.

--==================--
-- Type Declaration --
--==================--

--- @enum Side
local Side = {
	LEFT = 0, -- The left side of either the header-line or status-line. [ LEFT ... ]
	RIGHT = 1, -- The right side of either the header-line or status-line. [ ... RIGHT]
}

--- @enum SeparatorType
local SeparatorType = {
	OUTER = 0, -- Separators on the outer side of sections. [ c o | c o | c o ... ] or [ ... o c | o c | o c ]
	INNER = 1, -- Separators on the inner side of sections. [ c i c | c i c | c i c ... ] or [ ... c i c | c i c | c i c ]
}

--- @enum ComponentType
local ComponentType = {
	A = 0, -- Components on the first section. [ A | | ... ] or [ ... | | A ]
	B = 1, -- Components on the second section. [ | B | ... ] or [ ... | B | ]
	C = 2, -- Components on the third section. [ | | C ... ] or [ ... C | | ]
}

--- @alias Colored [string, Color] Stores text and its foreground color.
--- @alias Coloreds Colored[] The array of Coloreds.

--- @generic T
--- @alias T T Type of the component.

--- @class Yatline
--- @field config YatlineConfig Configuration of Yatline.
--- @field string? {} Table that stores string components.
--- @field line? {} Table that stores Line components.
--- @field coloreds? {} Table that stores Coloreds components.
Yatline = {}

--- @class (exact) ComponentConfig
--- @field type string Defines the type of the component (T).
--- @field custom? boolean Toggles the usage of a function defined or name field.
--- @field name string | T Either defined function name or variable of defined type T.
--- @field params? {} Contains the parameters that can be used by the function called.

--- @class (exact) SideConfig
--- @field section_a ComponentConfig[] Array of configuration of components in the first section.
--- @field section_b ComponentConfig[] Array of configuration of components in the second section.
--- @field section_c ComponentConfig[] Array of configuration of components in the third section.

--- @class (exact) LineConfig
--- @field left SideConfig Configuration of the left side of the line.
--- @field right SideConfig Configuration of the right side of the line.

--- @class (exact) YatlineConfig
--- @field section_separator {open: string, close: string} Separators that are between sections.
--- @field part_separator {open: string, close: string} Separators that are between components.
--- @field inverse_separator {open: string, close: string} Separators that are used when foreground color of separator is reset.
--- @field padding {inner: integer, outer: integer} Number of space padding surronding the component.
--- @field style_a {bg: Color, fg: Color