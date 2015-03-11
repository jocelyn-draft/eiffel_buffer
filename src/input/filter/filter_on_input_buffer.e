note
	description: "Summary description for {FILTER_ON_INPUT_BUFFER}."
	author: ""
	date: "$Date: 2012-10-30 21:48:16 +0100 (mar., 30 oct. 2012) $"
	revision: "$Revision: 89763 $"

deferred class
	FILTER_ON_INPUT_BUFFER

inherit
	INPUT_BUFFER

feature -- Change

	set_source (src: like source)
		do
			source := src
		end

feature -- Access

	source: INPUT_BUFFER

feature -- Access		

	name: READABLE_STRING_32
		do
			Result := source.name
		end

feature -- Status report

	end_of_input: BOOLEAN
			-- Has the end of input BUFFER been reached?
		do
			Result := source.end_of_input
		end

	is_open_read: BOOLEAN
			-- Can items be read from input BUFFER?
		do
			Result := source.is_open_read
		end

feature -- Access

	index: INTEGER
			-- Current position in the input BUFFER
		do
			Result := source.index
		end

	line: INTEGER
			-- Current line number
		do
			Result := source.line
		end

	column: INTEGER
			-- Current column number
		do
			Result := source.column
		end

	last_character_code: NATURAL_32
			-- Last read character
		deferred
		end

feature -- Basic operation

	read_character_code
			-- Read a character's code
			-- and keep it in `last_character_code'
		deferred
		end

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
