class_name Player extends Node3D

const TRAVEL_TIME := 0.3

@onready var rayFront : RayCast3D = $RayCastFront
@onready var rayBack : RayCast3D = $RayCastBack
@onready var rayRight : RayCast3D = $RayCastRight
@onready var rayLeft : RayCast3D = $RayCastLeft

var tween

func _physics_process(delta: float) -> void:
	# check that we arent mid-move
	if tween:
		if tween.is_running():
			return
	# movement
	if Input.is_action_pressed("move_forward") and not rayFront.is_colliding():
		tween = create_tween()
		tween.tween_property(self, "transform", transform.translated_local(Vector3.FORWARD * 2), TRAVEL_TIME)
	if Input.is_action_pressed("move_backward") and not rayBack.is_colliding():
		tween = create_tween()
		tween.tween_property(self, "transform", transform.translated_local(Vector3.BACK * 2), TRAVEL_TIME)
	if Input.is_action_pressed("strafe_left") and not rayLeft.is_colliding():
		tween = create_tween()
		tween.tween_property(self, "transform", transform.translated_local(Vector3.LEFT * 2), TRAVEL_TIME)
	if Input.is_action_pressed("straife_right") and not rayRight.is_colliding():
		tween = create_tween()
		tween.tween_property(self, "transform", transform.translated_local(Vector3.RIGHT * 2), TRAVEL_TIME)
	# rotation
	if Input.is_action_pressed("rotate_clock"):
		tween = create_tween()
		tween.tween_property(self, "transform", transform.rotated_local(Vector3.UP, -PI/2), TRAVEL_TIME)
	if Input.is_action_pressed("rotate_counter"):
		tween = create_tween()
		tween.tween_property(self, "transform", transform.rotated_local(Vector3.UP, PI/2), TRAVEL_TIME)
