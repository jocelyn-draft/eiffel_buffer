note
	description: "Summary description for {INPUT_BUFFER_WITH_CHECKPOINTS}."
	author: "Jocelyn Fiat"
	date: "$Date$"
	revision: "$Revision$"

class
	INPUT_BUFFER_WITH_CHECKPOINTS

inherit
	FILTER_ON_INPUT_BUFFER
		redefine
			index,
			end_of_input
		end

create
	make_from_source

feature {NONE} -- Initialization

	make_from_source (s: like source)
		do
			set_source (s)
			create check_points.make (0)
		end

feature -- Status report

	end_of_input: BOOLEAN
		do
			Result := (not attached check_point_buffer as cp_buf or else check_point_buffer_index >= cp_buf.count) and Precursor
		end

	index: INTEGER
			-- Current position in the input BUFFER
		do
			if attached check_point_buffer as cp_buf then
				Result := Precursor - cp_buf.count + check_point_buffer_index
			else
				Result := Precursor
			end
		end

feature -- Access

	last_character_code: NATURAL_32
			-- Last read character

feature -- Basic operation

	read_character_code
			-- Read a character's code
			-- and keep it in `last_character_code'
		do
			if attached check_point_buffer as cp_buf then
				check_point_buffer_index := check_point_buffer_index + 1
				if cp_buf.valid_index (check_point_buffer_index) then
					last_character_code := cp_buf [check_point_buffer_index].natural_32_code
				else
					check_point_buffer_index := 0
					check_point_buffer := Void
					source.read_character_code
					last_character_code := source.last_character_code

					if attached last_check_point as l_cp then
						l_cp.extend (last_character_code.to_character_32)
					end
				end
			else
				source.read_character_code
				last_character_code := source.last_character_code

				if attached last_check_point as l_cp then
					l_cp.extend (last_character_code.to_character_32)
				end
			end
		ensure then
			check_point_buffer = Void implies source.last_character_code = last_character_code
		end

feature -- Checkpoints access

	check_points: ARRAYED_LIST [TUPLE [index: INTEGER; text: STRING_32; name: detachable STRING]]

	check_point_buffer: detachable STRING_32
	check_point_buffer_index: INTEGER

	is_same_check_point_name (a_name_1, a_name_2: detachable STRING): BOOLEAN
		do
			if a_name_1 = a_name_2 then
				Result := True
			elseif a_name_1 = Void then
				Result := False -- a_name_2 could not be Void here
			elseif a_name_2 /= Void then
				Result := a_name_1.same_string (a_name_2)
			end
		end

	last_check_point_name: detachable STRING
		require
			not check_points.is_empty implies check_points.islast
		do
			if attached check_points as lst and then not lst.is_empty then
				Result := lst.item.name
			end
		ensure
			not check_points.is_empty implies check_points.islast
		end

	last_check_point: detachable STRING_32
		require
			not check_points.is_empty implies check_points.islast
		do
			if attached check_points as lst and then not lst.is_empty then
				Result := lst.item.text
			end
		ensure
			not check_points.is_empty implies check_points.islast
		end

	last_checkpoint_name: detachable STRING

feature -- Checkpoints operation

	add_check_point (a_name: STRING)
		local
			s: like last_check_point
			i: like check_point_buffer_index
		do
			if attached check_point_buffer as cp_buf then
				s := cp_buf
				i := check_point_buffer_index
			else
				create s.make_empty
				s.append_code (last_character_code) -- CHECK
				i := 0
			end
			check_points.force ([i, s, a_name])
			check_points.finish
		ensure
			not check_points.is_empty and check_points.islast
		end

	remove_check_point (a_name: STRING)
		require
			is_last: not check_points.is_empty and then check_points.islast
			same_name: is_same_check_point_name (check_points.item.name, a_name)
		do
			if attached check_points as lst then
				check lst.item.name ~ a_name end
				lst.remove
				if not lst.is_empty then
					lst.finish
				end
			end
		ensure
			not check_points.is_empty implies check_points.islast
		end

	rollback_check_point (a_name: STRING)
		require
			is_last: not check_points.is_empty and check_points.islast
			same_name: is_same_check_point_name (check_points.item.name, a_name)
		local
			s: like last_check_point
		do
			if attached check_points as lst then
				s := lst.item.text
				if lst.item.index = 0 then
					check check_point_buffer = Void end
					check_point_buffer_index := 1
				else
					check_point_buffer_index := lst.item.index
				end
				check_point_buffer := s
				last_character_code := s[check_point_buffer_index].natural_32_code
				lst.remove

				if not lst.is_empty then
					lst.finish
				end
			else
				check False end
			end
		ensure
			is_last: not check_points.is_empty implies check_points.islast
		end

end
