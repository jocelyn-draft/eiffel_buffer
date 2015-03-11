note
	description: "Summary description for {INPUT_BUFFER}."
	date: "$Date: 2012-10-30 21:48:16 +0100 (mar., 30 oct. 2012) $"
	revision: "$Revision: 89763 $"

deferred class
	INPUT_BUFFER

feature -- Access		

	name: READABLE_STRING_32
			-- Name associated with `Current'.
		deferred
		end

feature -- Status report

	end_of_input: BOOLEAN
			-- Has the end of input BUFFER been reached ?
		deferred
		end

	is_open_read: BOOLEAN
			-- Can items be read from input BUFFER ?
		deferred
		end

feature -- Access

	index: INTEGER
			-- Current position in the input BUFFER.
		deferred
		end

	line: INTEGER
			-- Current line number.
		deferred
		end

	column: INTEGER
			-- Current column number.
		deferred
		end

	last_character_code: NATURAL_32
			-- Last read character code.
		deferred
		end

feature -- Basic operation

	read_character_code
			-- Read a character's code
			-- and keep it in `last_character_code'
		require
			not_end_of_input: not end_of_input
		deferred
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
