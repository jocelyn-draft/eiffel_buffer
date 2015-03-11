note
	description: "Summary description for {STRING_INPUT_BUFFER}."
	date: "$Date: 2012-10-30 21:48:16 +0100 (mar., 30 oct. 2012) $"
	revision: "$Revision: 89763 $"

class
	STRING_INPUT_BUFFER

inherit
	INPUT_BUFFER

create
	make,
	make_empty

feature {NONE} -- Initialization

	make (a_string: READABLE_STRING_GENERAL)
		do
			source := a_string
			count := a_string.count
			start
		end

	make_empty
		do
			make ("")
		end

feature -- Access

	name: STRING_32 = "STRING"
			-- Name of current BUFFER

feature -- Status report

	count: INTEGER

	end_of_input: BOOLEAN

	is_open_read: BOOLEAN
			-- Can items be read from input BUFFER?
		do
			Result := True
		end

feature -- Access

	index: INTEGER
		do
			Result := source_index - 1
		end

	line: INTEGER

	column: INTEGER

	last_character_code: NATURAL_32
		do
			Result := last_character.natural_32_code
		end

	last_character: CHARACTER_32

feature -- Basic operation

	read_character_code
		do
			read_character
		end

	read_character
		local
			c: like last_character
		do
			c := source.item (source_index)
			source_index := source_index + 1

			if last_character = '%N' then
				line := line + 1
				column := 0
			else
				column := column + 1
			end
			last_character := c

			end_of_input := source_index > count
		end

	start
		do
			source_index := 1
			end_of_input := source_index > count
			line := 1
			column := 0
		end

	close
		do
		end

feature {NONE} -- Implementation

	source_index: INTEGER

	source: READABLE_STRING_GENERAL

invariant
	source_attached: source /= Void

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
