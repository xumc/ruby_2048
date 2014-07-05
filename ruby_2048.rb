class Object
	def invoke(need, method)
		if need
			self.send(method) 
		else
			self
		end
	end
end

class R2048
	attr_reader :chessboard
	LEFT = "l"
	RIGHT = "r"
	TOP = "t"
	BOTTOM = "b"
	EXIT = "e"

	def initialize
	    @chessboard = Array.new(4){|x| Array.new(4){|y| 0}}
		1.upto(2){|i| generate_init_num}
	end

	def generate_init_num
		return false unless @chessboard.flatten.uniq.select{|chess| chess == 0}.count > 0

		rand_position = rand(16)
		x, y = rand_position/4, rand_position % 4
		until @chessboard[x][y] == 0
			rand_position = rand(16)
			x, y = rand_position/4, rand_position % 4
	    end
	    @chessboard[x][y] = [2, 4][rand(2)]

	end

	def check_and_merge(transpose, reverse)
		moved = false
		temp_chessboard = @chessboard.invoke(transpose, :transpose).map do |row|
			reversed_row = set_jump_step(row.invoke(reverse, :reverse)).invoke(reverse, :reverse)
			moved = true if reversed_row != row.invoke(reverse, :reverse)
			reversed_row
		end.invoke(transpose, :transpose)

		if moved
			@chessboard = temp_chessboard 
			true
		else
			false
		end
	end

	def generate_new_num(transpose, pos)
		ungenerated = true
		@chessboard = @chessboard.invoke(transpose, :transpose).map do |row|
			if ungenerated && row[pos] == 0
				ungenerated = false
				row[pos] = [2, 4][rand(2)]
			end
			row
		end.invoke(transpose, :transpose)
		!ungenerated
	end

	def set_jump_step(row)
	  pured = row.select{|chess| chess != 0 }.inject([]) do |sum, chess|
	  	if sum.last == chess
	  		sum.pop 
	  		sum << chess * 2
	  	else
	  		sum << chess
	  	end
	  end
	  pured.concat Array.new(4 - pured.count, 0)
	end

	def display
	  puts "==========================================================="
      @chessboard.each_with_index do |c, row|
      	puts "#{c[0]}	#{c[1]}	#{c[2]}	#{c[3]}"
      	puts
      end
	end

	def failure_display
		puts "you have failed!!!"
	end

	def run
		display
		key = nil
		until key == "e\n"
			key = gets
			key.gsub!("\n", "")
			return if key == EXIT

			if ![LEFT, RIGHT, TOP, BOTTOM].include? key
				puts "input error" 
				next
			end

			generate = case key
			when LEFT
				if check_and_merge(false, false)
					generate_new_num(false, 3)
				end
			when RIGHT
				if check_and_merge(false, true)
					generate_new_num(false, 0)
				end
			when TOP
				if check_and_merge(true, false)
					generate_new_num(true, 3)
				end
			when BOTTOM
				if check_and_merge(true, true)
					generate_new_num(true, 0)
				end
			end

			if generate == nil || generate
			  display
			else
			  failure_display
			  return
			end
		end
	end
end

R2048.new.run


