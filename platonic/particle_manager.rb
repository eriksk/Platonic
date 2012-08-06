module Platonic
	class ParticleManager
		def initialize game
			@game = game
			@particles = []
			@heart_tex = game.load_image('heart')
		end

		def clear
			@particles.clear			
		end

		def spawn_hearts position
			10.times do |i|
				p = Heart.new(@heart_tex, 1000 + (rand() * 4000))
				p.position.x = position.x + (-0.5 + rand()) * 100
				p.position.y = position.y + (-0.5 + rand()) * 100
				@particles.push(p)
			end
		end

		def update dt	
			@particles.each do |p|
				p.update dt
				if !p.alive
					@particles.delete p
				end
			end
		end

		def draw
			@particles.each do |p|
				p.draw
			end
		end
	end
end