extends Node3D

enum STATES{WANDERING, CHASING}
var curState : STATES = STATES.WANDERING
var gotoPosition : Vector3
var tween
const TRAVEL_TIME := 0.1

@onready var rayMove := $MovementRaycast
@onready var health := $Health
@onready var hurtbox := $Hurtbox

@onready var visionRayFront := $VisionRaycasts/RayCastFront
@onready var visionRayRight := $VisionRaycasts/RayCastRight
@onready var visionRayLeft := $VisionRaycasts/RayCastLeft
@onready var visionRayBack := $VisionRaycasts/RayCastBack

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().get_first_node_in_group("player").connect("player_step", move)
	$Hitbox.monitoring = false	# DEBUG: temporary
	hurtbox.connect("hurt", health.damage)
	health.connect("health_empty", die)

# NOTE: temporary setup just to store movement functions we need. need to figure out pathfinding later
func move() -> void:
	# NOTE: don't want enemies to be able to side/back step since it looks weird. (we are fine with instant turns)
	# move forward
	tween = create_tween()
	tween.tween_property(self, "transform", transform.translated_local(Vector3.FORWARD * Globs.TILEWIDTH), TRAVEL_TIME)
	# turn clockwise
	self.transform.rotated_local(Vector3.UP, -PI/2)
	# turn counter clockwise
	self.transform.rotated_local(Vector3.UP, PI/2)

func die() -> void:
	queue_free()
