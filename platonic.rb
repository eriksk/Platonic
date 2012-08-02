require 'gosu'
require_relative 'platonic/game.rb'

$WIDTH = 800
$HEIGHT = 600
$FULLSCREEN = false
game = Platonic::Game.new
game.show
