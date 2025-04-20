extends Node

const MAX_HP = 6
const TILEWIDTH  : int = 2
const TIME_REMAINING_MAX: int = 250
const TIME_REMAINING_LOWER: int = 1
const TIME_REMAINING_UPPER: int = 5

var spiritCounter = 0
var muteMusic : bool = false
var muteSFX : bool = false
# toggle this with the line muteSFX = not muteSFX
# use buttons pressed signal
