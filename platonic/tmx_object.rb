module Platonic
	class TmxObject
		
		attr_accessor :width, :height, :name, :type, :x, :y

		def initialize hash
			@width = hash['width']
			@height = hash['height']
			@name = hash['name']
			@type = hash['type']
			@x = hash['x'].to_i
			@y = hash['y'].to_i
		end
	end
end