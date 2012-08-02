module Platonic
	class Game < Gosu::Window
		include Gosu
		
		def initialize
			super $WIDTH, $HEIGHT, $FULLSCREEN
			self.caption = "Platonic"
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

		def update
		end

		def draw
		end
	end
end