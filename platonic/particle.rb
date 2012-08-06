module Platonic
	class Particle < Entity

		attr_accessor :velocity, :current, :duration

		def initialize texture, duration
			super(texture)
			@duration = duration
		end

		def load
			@velocity = Vec2.new
			@current = 0.0
		end

		def alive
			@current < @duration
		end

		def progress
			@current / @duration
		end

		def update dt
			@current += dt
			@position.x += @velocity.x * dt
			@position.y += @velocity.y * dt
		end
	end
end