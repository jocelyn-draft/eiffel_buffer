note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	INPUT_BUFFER_WITH_CHECKPOINTS_TEST_SET

inherit
	EQA_TEST_SET

feature -- Test routines

	test_checkpoints
			-- New test routine
		local
			s: STRING
			i: STRING_8_INPUT_BUFFER
			cp: INPUT_BUFFER_WITH_CHECKPOINTS
			l_code: NATURAL_32
		do
			s := "this is a test for check points."
			create i.make (s)
			i.start
			i.read_character -- t
			assert ("is t", i.last_character = 't')
			i.read_character -- h
			assert ("is h", i.last_character = 'h')
			i.read_character -- i
			assert ("is i", i.last_character = 'i')
			i.read_character -- s
			assert ("is s", i.last_character = 's')
			i.read_character -- space
			assert ("is_space", i.last_character.is_space)

			create cp.make_from_source (i)
			i.start
			cp.read_character_code -- t
			assert ("is t", cp.last_character_code.to_character_32 = 't')

			cp.read_character_code -- h
			assert ("is h", cp.last_character_code.to_character_32 = 'h')

			cp.read_character_code -- i
			assert ("is i", cp.last_character_code.to_character_32 = 'i')

			cp.read_character_code -- s
			assert ("is s", cp.last_character_code.to_character_32 = 's')

			cp.read_character_code -- space
			assert ("is space", cp.last_character_code.to_character_32.is_space)

			cp.read_character_code -- i
			cp.read_character_code -- s
			cp.read_character_code -- space
			cp.read_character_code -- a
			cp.read_character_code -- space

			cp.add_check_point ("test")
			l_code := cp.last_character_code
			cp.read_character_code -- t
			cp.read_character_code -- e
			cp.read_character_code -- s
			cp.read_character_code -- t
			cp.rollback_check_point ("test")
			assert ("is " + l_code.to_character_32.out, cp.last_character_code = l_code)

			cp.add_check_point ("test")
			l_code := cp.last_character_code
			cp.read_character_code -- t
			assert ("is t", cp.last_character_code.to_character_32 = 't')
			cp.read_character_code -- e
			assert ("is e", cp.last_character_code.to_character_32 = 'e')
			cp.read_character_code -- s
			assert ("is s", cp.last_character_code.to_character_32 = 's')
			cp.read_character_code -- t
			assert ("is t", cp.last_character_code.to_character_32 = 't')

			cp.read_character_code -- space
			cp.add_check_point ("for")
			l_code := cp.last_character_code
			cp.read_character_code -- f
			cp.read_character_code -- o
			cp.read_character_code -- r
			cp.rollback_check_point ("for")
			assert ("is " + l_code.to_character_32.out, cp.last_character_code = l_code)
			
			cp.read_character_code -- f
			assert ("is f", cp.last_character_code.to_character_32 = 'f')
			cp.read_character_code -- o
			assert ("is o", cp.last_character_code.to_character_32 = 'o')
			cp.read_character_code -- r
			assert ("is r", cp.last_character_code.to_character_32 = 'r')

			cp.remove_check_point ("test")

--			assert ("not_implemented", False)
		end

end


