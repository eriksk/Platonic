module Platonic
	class Heart < Particle
		def update dt
			@current += dt
			@position.x += @velocity.x * dt
			@position.y += @velocity.y * dt
			@rotation = Math::sin(@current * 0.01)
		end
	end
end