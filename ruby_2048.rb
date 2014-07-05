class R2048
	attr_reader :chessboard
	LEFT = "l"
	RIGHT = "r"
	TOP = "t"
	BOTTOM = "b"

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

	def check_and_merge(direction)#transpose?, reverse?)
		case direction
		when LEFT
			@chessboard = @chessboard.map do |row|
			  set_jump_step(row)
			end
		when RIGHT
			@chessboard = @chessboard.map do |row|
			  set_jump_step(row.reverse).reverse
			end
		when TOP
			@chessboard = @chessboard.transpose.map do |row|
			  set_jump_step(row)
			end.transpose
		when BOTTOM
			@chessboard = @chessboard.transpose.map do |row|
			  set_jump_step(row.reverse).reverse
			end.transpose
		else
			puts "input error"
		end
	end

	def generate_new_num(direction)
		ungenerated = true
		case direction
		when LEFT
			@chessboard.map! do |row|
				if ungenerated && row[3] == 0
					ungenerated = false
					row[3] = [2, 4][rand(2)]
				end
				row
			end
		when RIGHT
			@chessboard.map! do |row|
				if ungenerated && row[0] == 0
					ungenerated = false
					row[0] = [2, 4][rand(2)]
				end
				row
			end
		when TOP
			@chessboard = @chessboard.transpose.map! do |row|
				if ungenerated && row[3] == 0
					ungenerated = false
					row[3] = [2, 4][rand(2)]
				end
				row
			end.transpose
		when BOTTOM
			@chessboard = @chessboard.transpose.map! do |row|
				if ungenerated && row[0] == 0
					ungenerated = false
					row[0] = [2, 4][rand(2)]
				end
				row
			end.transpose
		else
			puts "input error"
		end

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
			return if key == "e\n"
			key.gsub!("\n", "")
			check_and_merge(key)

			if generate_new_num(key)
			  display
			else
			  failure_display
			  return
			end
		end
	end
end

R2048.new.run


