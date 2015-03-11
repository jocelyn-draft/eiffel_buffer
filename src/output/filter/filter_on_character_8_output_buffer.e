note
	description: "Summary description for {FILTER_ON_CHARACTER_8_OUTPUT_BUFFER}."
	date: "$Date: 2012-10-30 21:05:23 +0100 (mar., 30 oct. 2012) $"
	revision: "$Revision: 89762 $"

deferred class
	FILTER_ON_CHARACTER_8_OUTPUT_BUFFER

inherit
	OUTPUT_BUFFER

feature -- Change

	set_target (a_target: like target)
		do
			target := a_target
		end

feature -- Access

	target: CHARACTER_8_OUTPUT_BUFFER

feature -- Status report

	is_open_write: BOOLEAN
			-- Can items be write into output BUFFER?
		do
			Result := target.is_open_write
		end

feature -- Output character

	put_character_8 (c: CHARACTER_8)
		do
			target.put_character_8 (c)
		end

	put_string_8 (a_string: READABLE_STRING_8)
			-- Write `a_string' to output BUFFER.
		do
			target.put_string_8 (a_string)
		end

feature -- Basic operations

	flush
			-- Flush buffered data to disk.
		do
			target.flush
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
