note
	description: "Summary description for {FILTER_ON_CHARACTER_8_INPUT_BUFFER}."
	author: ""
	date: "$Date: 2012-10-30 21:48:16 +0100 (mar., 30 oct. 2012) $"
	revision: "$Revision: 89763 $"

deferred class
	FILTER_ON_CHARACTER_8_INPUT_BUFFER

inherit
	FILTER_ON_INPUT_BUFFER
		redefine
			source
		end

feature -- Access

	source: CHARACTER_8_INPUT_BUFFER

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
