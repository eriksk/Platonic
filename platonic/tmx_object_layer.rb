module Platonic
	class TmxObjectLayer

		attr_accessor :name, :objects

		def initialize hash
			@name = hash['name']
			@objects = []
			hash['objects'].each do |obj|
				@objects.push TmxObject.new(obj)
			end
		end

		def get_object name
			@objects.each do |obj|
				if obj.name == name
					return obj
				end
			end
			nil
		end
	end
end