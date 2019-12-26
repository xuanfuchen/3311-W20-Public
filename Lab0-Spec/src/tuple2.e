note
	description: "[
		Arbitrary 2-tuple [x, y] where x and y are DECIMAL.
		]"
class
	TUPLE2

inherit

	COMPARABLE
		redefine
			is_equal,
			out
		end

	DEBUG_OUTPUT
		undefine
			is_equal,
			out
		end

create
	make, make_from_tuple, make_from_string

convert
	make_from_tuple ({TUPLE [DECIMAL, DECIMAL]}),
	make_from_string ({TUPLE [STRING, STRING]}),
	as_tuple: {TUPLE [DECIMAL, DECIMAL]}

feature -- Queries

	x: DECIMAL

	y: DECIMAL

feature -- Constructor

	make (a_x: DECIMAL; a_y: DECIMAL)
		do
			x := a_x
			y := a_y
		end

	make_from_tuple (t: TUPLE [x: DECIMAL; y: DECIMAL])
		require
			t.count = 2
			attached {DECIMAL} t.x
			attached {DECIMAL} t.y
		do
			make (t.x, t.y)
		end

	make_from_string (t: TUPLE [x: STRING; y: STRING])
		require
			t.count = 2
			attached {STRING} t.x
			attached {STRING} t.y
		local
			l_x, l_y: DECIMAL
		do
			l_x := t.x
			l_y := t.y
			make (l_x, l_y)
		end

	as_tuple: TUPLE [DECIMAL, DECIMAL]
		do
			Result := [x, y]
			Result.compare_objects
		end

feature -- Equality

	is_equal (other: like Current): BOOLEAN
			-- Is current pair equal to 'other'?
		do
			Result := x ~ other.x and then y ~ other.y
		ensure then
			Result = (x ~ other.x and then y ~ other.y)
		end

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is current object less than `other'?
		do
			Result := hypotenuse < other.hypotenuse
		ensure then
			Result = (hypotenuse < other.hypotenuse)
		end

	hypotenuse: DECIMAL
		do
			Result := (x * x + y * y)
		ensure
			Result ~ (x * x + y * y)
		end

feature -- Debug output

	out: STRING
		do
			Result := "[" + x.precise_out + "," + y.precise_out + "]"
		end

	debug_output: STRING
		do
			Result := out
		end

invariant
	hypotenuse >= hypotenuse.zero

end