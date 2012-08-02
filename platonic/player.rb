module Platonic
	class Player < Character

		def initialize game, textures
			super(textures[0])
			@textures = textures
			@velocity = Vec2.new
			@game = game
			@current_animation = :idle
			@animations = {
				:idle => Animation.new(0, 200),
				:walk => Animation.new(Array(4..7), 150),
				:jump => Animation.new(Array(8..9), 100)
			}
			@flipped = false
			@gounded = false
			
			@gravity = 0.001
			@speed = 0.001
			@friction = 0.9
			@jump_speed = 0.3
			@floor = 500
		end

		def set_anim(anim)
			if @current_animation != anim
				@current_animation = anim
				@animations[@current_animation].reset
			end
		end

		def update dt

			@velocity.x *= @friction
			@position.x += @velocity.x * dt
			@position.y += @velocity.y * dt

			if @grounded
				if @game.button_down?(Gosu::KbUp)
					@velocity.y = -@jump_speed
					@grounded = false
				elsif @game.button_down?(Gosu::KbLeft)
					@velocity.x -= @speed * dt
					set_anim(:walk)
					@flipped = true
				elsif @game.button_down?(Gosu::KbRight)
					@velocity.x += @speed * dt
					set_anim(:walk)
					@flipped = false
				else
					set_anim(:idle)
				end
			else
				set_anim(:jump)
				if @game.button_down?(Gosu::KbLeft)
					@velocity.x -= @speed * dt
					@flipped = true
				elsif @game.button_down?(Gosu::KbRight)
					@velocity.x += @speed * dt
					@flipped = false
				end
				@velocity.y += @gravity * dt
				if @position.y >= @floor
					@position.y = @floor
					@grounded = true
					@velocity.y = 0.0
				end
			end
			@animations[@current_animation].update dt
		end

		def draw
			if @flipped
				@textures[@animations[@current_animation].frame].draw_rot(@position.x, @position.y, 0, @rotation.to_degrees, 0.5, 0.5, -1.0, 1.0)
			else
				@textures[@animations[@current_animation].frame].draw_rot(@position.x, @position.y, 0, @rotation.to_degrees)
			end
		end
	end
end