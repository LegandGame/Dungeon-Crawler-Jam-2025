extends Node3D

enum STATES{WANDERING, CHASING}
var curState : STATES = STATES.CHASING
var playerPos : Vector3
var playerRef : Node3D
var tween
const TRAVEL_TIME := 0.1

@onready var rayMove := $MovementRaycast
@onready var health := $Health
@onready var hurtbox := $Hurtbox
@onready var moveCast := $MovementRaycast
@onready var animPlayer : AnimationPlayer = $AnimationPlayer
@onready var marker : Marker3D = $Marker3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hurtbox.connect("hurt", health.damage)
	health.connect("health_empty", die)
	playerRef = get_tree().get_first_node_in_group("player")
	playerPos = playerRef.position
	playerRef.connect("player_step", step)
	rayMove.add_exception(hurtbox)

# NOTE: temporary setup just to store movement functions we need. need to figure out pathfinding later
func step() -> void:
	playerPos = playerRef.position
	match curState:
		#aggro if we get close enough to the player
		STATES.WANDERING:
			if position.distance_to(playerPos) <= 20.0:
				curState = STATES.CHASING
		STATES.CHASING:
			# face the player
			# the math part
			var dirToPlayer = position.direction_to(playerPos)
			var forwardFacing = -global_transform.basis.z
			var rightFacing = global_transform.basis.x
			# -1 = back, 1 = forward,
			var dotF = forwardFacing.dot(dirToPlayer)
			# -1 = rights, 1 = left
			var dotR = rightFacing.dot(dirToPlayer)
			# actually facing the right way
			if dotF >= 0.2:		#player is in front of us. do nothing
				pass
			elif dotF <= -0.2:	# player is behind us. turn 180
				rotate_clockwise()
				rotate_clockwise()
			if dotR >= 0.2:
				rotate_clockwise()
			elif dotR <= -0.2:
				rotate_counter_clockwise()
			
			# attack if we're close enough
			if position.distance_to(playerPos) <= 2.4:
				attack()
			else:
				move_forward()

func move_forward() -> void:
	moveCast.force_raycast_update()
	#print(!moveCast.is_colliding(), !($Marker3D.position != playerRef.gotoPos))
	if !moveCast.is_colliding():# and !($Marker3D.position != playerRef.gotoPos):
		tween = create_tween()
		tween.tween_property(self, "transform", transform.translated_local(Vector3.FORWARD * Globs.TILEWIDTH), TRAVEL_TIME)

func rotate_clockwise() -> void:
	rotate(Vector3.UP, -PI/2)

func rotate_counter_clockwise() -> void:
	rotate(Vector3.UP, PI/2)

func die() -> void:
	queue_free()

func attack() -> void:
	animPlayer.play("attack")
