require 'gosu'
require_relative 'platonic/game'
require_relative 'platonic/helpers'
require_relative 'platonic/vec2'
require_relative 'platonic/entity'
require_relative 'platonic/character'
require_relative 'platonic/player'
require_relative 'platonic/animation'
require_relative 'platonic/tmx_layer'
require_relative 'platonic/tmx_tile_map'

$WIDTH = 800
$HEIGHT = 600
$FULLSCREEN = false

# entry point
game = Platonic::Game.new
game.show
