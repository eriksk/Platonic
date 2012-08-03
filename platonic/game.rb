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
			@players[0].set_position(400, 32)
			@players[1].set_position(($WIDTH / 2.0) + 200, 32)
		
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
				player.update dt, @map.layers.first
			end
=begin
			if @players[0].insersect?(@players[1])
				if @players[0].position.x < @players[1].position.x
					@players[0].position.x -= 0.05 * dt
					@players[1].position.x += 0.05 * dt
				else
					@players[0].position.x += 0.05 * dt
					@players[1].position.x -= 0.05 * dt
				end
			end
=end	
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
			end
		end
	end
end