class_name Player extends Node3D

@export var walk_speed : float
@export var sprint_speed : float
@onready var TRAVEL_TIME := walk_speed

@onready var rayFront : RayCast3D = $RayCastFront
@onready var rayBack : RayCast3D = $RayCastBack
@onready var rayRight : RayCast3D = $RayCastRight
@onready var rayLeft : RayCast3D = $RayCastLeft

var tween
signal player_step

func _physics_process(delta: float) -> void:
	# check that we arent mid-move
	if tween:
		if tween.is_running():
			return
	# movement
	if Input.is_action_pressed("move_forward") and not rayFront.is_colliding():
		tween = create_tween()
		tween.tween_property(self, "transform", transform.translated_local(Vector3.FORWARD * 2), TRAVEL_TIME)
		player_step.emit()
	if Input.is_action_pressed("move_backward") and not rayBack.is_colliding():
		tween = create_tween()
		tween.tween_property(self, "transform", transform.translated_local(Vector3.BACK * 2), TRAVEL_TIME)
		player_step.emit()
	if Input.is_action_pressed("strafe_left") and not rayLeft.is_colliding():
		tween = create_tween()
		tween.tween_property(self, "transform", transform.translated_local(Vector3.LEFT * 2), TRAVEL_TIME)
		player_step.emit()
	if Input.is_action_pressed("straife_right") and not rayRight.is_colliding():
		tween = create_tween()
		tween.tween_property(self, "transform", transform.translated_local(Vector3.RIGHT * 2), TRAVEL_TIME)
		player_step.emit()
	# rotation
	if Input.is_action_pressed("rotate_clock"):
		tween = create_tween()
		tween.tween_property(self, "transform", transform.rotated_local(Vector3.UP, -PI/2), TRAVEL_TIME)
	if Input.is_action_pressed("rotate_counter"):
		tween = create_tween()
		tween.tween_property(self, "transform", transform.rotated_local(Vector3.UP, PI/2), TRAVEL_TIME)
	# wait
	if Input.is_action_pressed("wait"):
		player_step.emit()
	
	# sprinting
	if Input.is_action_pressed("sprint"):
		if TRAVEL_TIME == walk_speed:
			TRAVEL_TIME = sprint_speed
		else:
			TRAVEL_TIME = walk_speed
