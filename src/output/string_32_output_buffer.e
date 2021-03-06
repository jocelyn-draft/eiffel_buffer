note
	description: "Summary description for {STRING_32_OUTPUT_BUFFER}."
	date: "$Date: 2012-10-30 21:05:23 +0100 (mar., 30 oct. 2012) $"
	revision: "$Revision: 89762 $"

class
	STRING_32_OUTPUT_BUFFER

inherit
	OUTPUT_BUFFER

create
	make, make_empty

feature {NONE} -- Initialization

	make_empty
			-- Create a blank BUFFER.
		do
			make ({STRING_32} "")
		end

	make (a_string: like string)
			-- Create current BUFFER for file `a_string'
		require
			a_string_attached: a_string /= Void
		do
			string := a_string
		ensure
			shared: string = a_string
		end

feature -- Status report

	string: STRING_32
			-- Target for the BUFFER

feature -- Status report

	is_open_write: BOOLEAN =True

feature -- Basic operation

	flush
			-- Flush buffered data to disk.
		do
		end

feature -- Output

	put_character_8 (c: CHARACTER_8)
		do
			string.append_character (c)
		end

	put_character_32 (c: CHARACTER_32)
		do
			string.append_character (c)
		end

	put_string_8 (a_string: READABLE_STRING_8)
			-- Write `a_string' to output BUFFER.
		do
			string.append_string_general (a_string)
		end

	put_string_32 (a_string: READABLE_STRING_32)
			-- Write `a_string' to output BUFFER.
		do
			string.append (a_string)
		end

invariant
	string_attached: string /= Void

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
