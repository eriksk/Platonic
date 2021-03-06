module Platonic
end

class Numeric
    def to_degrees
        self * 180 / Math::PI
    end
    def to_radians
        self * Math::PI / 180
    end
end
