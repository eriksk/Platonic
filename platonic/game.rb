module Platonic
	class Game < Gosu::Window
		include Gosu

		STATES = [:playing, :game_over]

		@state = :playing
		
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

			@particle_manager = ParticleManager.new(self)
			@state = :playing
		end

		def game_over
			@state = :game_over
		end

		def reset
			@players[0].set_position(@map.object_layers.first.get_object('p1').x, @map.object_layers.first.get_object('p1').y)
			@players[1].set_position(@map.object_layers.first.get_object('p2').x, @map.object_layers.first.get_object('p2').y)
			@players[0].reset
			@players[1].reset
			@state = :playing
		end

		def button_down(id)
			case id
				when KbEscape
					exit
				when KbReturn
					reset
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

			case @state
				when :playing
					@players.each do |player|
						player.update dt, @map.layers.first
					end

					if @players[0].intersect?(@players[1])
						@particle_manager.spawn_hearts(@players[0].position)
						game_over()
					end	
				when :game_over
			end

			@particle_manager.update dt
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
			@particle_manager.draw
		end
	end
end