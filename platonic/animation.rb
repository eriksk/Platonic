module Platonic
	class Animation

		def initialize frames, interval
			@frames = frames
			@interval = interval
			@current_frame = 0
			@current = 0.0
		end

		def frame
			@frames[@current_frame]
		end

		def reset
			@current_frame = 0
			@current = 0.0
		end

		def update dt
			@current += dt
			if @current > @interval
				@current = 0.0
				@current_frame += 1
				if @current_frame > @frames.size - 1
					@current_frame = 0
				end
			end
		end
	end
end