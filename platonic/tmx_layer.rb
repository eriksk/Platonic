module Platonic
	class TmxLayer

		attr_accessor :data, :name, :opacity, :width, :height, :x, :y, :textures

		def initialize hash
			@data = []
			hash['data'].each{|cell| @data.push cell}
			@name = hash['name']
			@opacity = hash['opacity']
			@width = hash['width']
			@height = hash['height']
			@x = hash['x']
			@y = hash['y']
			@textures = nil
		end

		# calls a block for every cell that is not 0.
		# params: col, row
		def each_collidable(&blk)
			@width.times do |i|
				@height.times do |j|
					cell = get_cell(i, j)
					if cell != 0
						blk.call(i, j)
					end
				end
			end
		end

		def get_cell col, row
			#puts "Getting cell w col:#{col} and row: #{row} and it has the value #{@data[col + row * @width]}"
			#puts @data
			if col + row * @width < @data.size
				@data[col + row * @width]
			else
				return 0
			end
		end

		def check_collision position
			col = (position.x / 16).to_i
			row = (position.y / 16).to_i
			return get_cell(col, row) > 0
		end

		def to_s
			puts "Name: #{name}"
			puts "Opacity: #{opacity}"
			puts "Width: #{width}"
			puts "Height: #{height}"
			puts "X: #{x}"
			puts "Y: #{y}"
		end

		def draw
			@width.times do |i|
				@height.times do |j|
					cell = get_cell(i, j)
					if(cell != 0)
						@textures[cell-1].draw(i * 16, j * 16, 0)
					end
				end
			end
		end
	end
end