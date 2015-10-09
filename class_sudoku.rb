class Sudoku

	def initialize(str_num)
		@str_num = str_num
		@matriz = create_sudoku!
		@todas_pos = revisa_todo
	end

	def create_sudoku!
		arr = @str_num.split("").map(&:to_i)
		mat = []
		while !arr.empty?
			mat << arr.pop(9)
		end
		mat.reverse
	end

	def print_sudoku
		puts "---------------------"
		n = 0
		@matriz.each do |x|
			puts "#{x[0]} #{x[1]} #{x[2]} | #{x[3]} #{x[4]} #{x[5]} | #{x[6]} #{x[7]} #{x[8]} "
			n +=1
			if n == 3 || n == 6
				puts "- - - - - - - - - - -"
			end
		end
		puts "---------------------"
	end

	def revisa_filas(mat)
		num = [1,2,3,4,5,6,7,8,9]
		resta = []
		mat.each do |x|
			resta << (num - x)
		end
		resta
	end

	def revisa_columnas
		revisa_filas(@matriz.transpose)
	end

	def formar_cuadritos
		arr = [[],[],[],[],[],[],[],[],[]]
		@matriz.each_with_index do |fil, fil_index|
			fil.each_with_index do |val, col_index|
				i = (fil_index / 3) + (col_index / 3) * 3
				arr[i].push(val)
			end
		end
		arr
	end

	def revisa_cuadritos
		revisa_filas(formar_cuadritos)
	end

	def revisa_todo
		rev1 = revisa_filas(@matriz)
		rev2 = revisa_columnas
		rev3 = revisa_cuadritos
		todas_pos = []

		@matriz.each_with_index do |fil, fil_index|
			fil.each_with_index do |val, col_index|
				i = (fil_index / 3) + (col_index / 3) * 3
				if val == 0
					pos = []
					pos1 = []
					pos << fil_index
					pos << col_index
					n = [1,2,3,4,5,6,7,8,9]
					n.each do |x|
						if rev1[fil_index].include?(x) && rev2[col_index].include?(x) && rev3[i].include?(x)
							pos1 << x
						end
					end
					pos << pos1
					todas_pos << pos
				end
			end
		end

		todas_pos
	end

	def rellena_sudoku
		while !@todas_pos.empty?
			@todas_pos.each do |x|
				if x[2].length == 1
					@matriz[x[0]][x[1]] = x[2][0]
					@todas_pos.delete(x)
					@todas_pos = revisa_todo
					break
				end
			end
		end
	end

end
game = Sudoku.new('702806519100740230005001070008000002610204053200000100070400800064078005821503907')
#game.print_sudoku
game.rellena_sudoku
game.print_sudoku

