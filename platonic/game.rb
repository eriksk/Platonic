module Platonic
	class Game < Gosu::Window
		include Gosu
		
		def initialize
			super $WIDTH, $HEIGHT, $FULLSCREEN
			self.caption = "Platonic"

			@top_color = Color::WHITE
			@bottom_color = Color::GRAY

			@player = Player.new(self, load_image_tiles('character', 16, 16))
			@player.set_position($WIDTH / 2.0, $HEIGHT / 2.0)
		
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

			@player.update dt
		end

		def draw
			draw_quad(
				0, 0, @top_color,
				$WIDTH, 0, @top_color,
				$WIDTH, $HEIGHT, @bottom_color,
				0, $HEIGHT, @bottom_color
			)
			@map.draw
			@player.draw
		end
	end
end