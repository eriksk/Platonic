module Platonic
	class Game < Gosu::Window
		include Gosu
		
		def initialize
			super $WIDTH, $HEIGHT, $FULLSCREEN
			self.caption = "Platonic"

			@top_color = Color::WHITE
			@bottom_color = Color::GRAY
			@color_red = Color::RED
			@color_red.alpha = 100

			@players = [
				Player.new(self, load_image_tiles('character_boy', 16, 16)),
				Player.new(self, load_image_tiles('character_girl', 16, 16))
			]	
			@players[0].set_position($WIDTH / 2.0, $HEIGHT / 2.0)
			@players[1].set_position(($WIDTH / 2.0) + 200, $HEIGHT / 2.0)
		
			@map = TmxTileMap.new
			@map.load('content/maps/map1.json', self)
		end

		def button_down(id)
			case id
				when KbEscape
					exit
			end
		end

		def load_image name
			Image.new(self, "content/gfx/#{name}.png", false)
		end

		def load_image_tiles name, tile_width, tile_height
			Image.load_tiles(self, "content/gfx/#{name}.png", tile_width, tile_height, true)
		end

		def update
			dt = 16.0

			@players.each do |player|
				player.update dt
				
				col = (player.position.x / 16).to_i
				row = (player.position.y / 16).to_i
				if @map.layers.first.get_cell(col, row) > 0
					x = col * 16
					y = row * 16
					if player.position.x < x + 8
						player.position.x = x
						# TODO: clear velocity.x
					else
						player.position.x = x + 16
					end
					if player.position.y + 8 > y
						# @player.position.y = y - 8
						# TODO: land player if in air? only check for floor if in air... u know
					end
				end
			end
		end

		def draw
			draw_quad(
				0, 0, @top_color,
				$WIDTH, 0, @top_color,
				$WIDTH, $HEIGHT, @bottom_color,
				0, $HEIGHT, @bottom_color
			)

			@map.draw

			@players.each do |player|
				player.draw

				col = (player.position.x / 16).to_i
				row = (player.position.y / 16).to_i
				if @map.layers.first.get_cell(col, row) > 0
					x = col * 16
					y = row * 16
					draw_quad(
						x, y, @color_red,
						x + 16, y, @color_red,
						x + 16, y + 16, @color_red,
						x, y + 16, @color_red
					)
				end
			end
		end
	end
end