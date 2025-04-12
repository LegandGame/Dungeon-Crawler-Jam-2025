class_name Player extends Node3D

const TRAVEL_TIME := 0.3

@onready var rayFront : RayCast3D = $RayCastFront
@onready var rayBack : RayCast3D = $RayCastBack
@onready var rayRight : RayCast3D = $RayCastRight
@onready var rayLeft : RayCast3D = $RayCastLeft
@onready var hurtBox : Hurtbox = $Hurtbox
@onready var health : Health = $Health

var tween
signal player_step

func _ready() -> void:
	# connect all signals here
	hurtBox.connect("hurt", health.damage)
	health.connect("health_empty", game_over)

func _physics_process(_delta: float) -> void:
	# check that we arent mid-move
	if tween:
		if tween.is_running():
			return
	# movement
	if Input.is_action_pressed("move_forward") and not rayFront.is_colliding():
		tween = create_tween()
		tween.tween_property(self, "transform", transform.translated_local(Vector3.FORWARD * 2), TRAVEL_TIME)
		player_step.emit()
	if Input.is_action_pressed("move_back") and not rayBack.is_colliding():
		tween = create_tween()
		tween.tween_property(self, "transform", transform.translated_local(Vector3.BACK * 2), TRAVEL_TIME)
		player_step.emit()
	if Input.is_action_pressed("strafe_left") and not rayLeft.is_colliding():
		tween = create_tween()
		tween.tween_property(self, "transform", transform.translated_local(Vector3.LEFT * 2), TRAVEL_TIME)
		player_step.emit()
	if Input.is_action_pressed("strafe_right") and not rayRight.is_colliding():
		tween = create_tween()
		tween.tween_property(self, "transform", transform.translated_local(Vector3.RIGHT * 2), TRAVEL_TIME)
		player_step.emit()
	# rotation
	if Input.is_action_pressed("turn_clock"):
		tween = create_tween()
		tween.tween_property(self, "transform", transform.rotated_local(Vector3.UP, -PI/2), TRAVEL_TIME)
	if Input.is_action_pressed("turn_counter"):
		tween = create_tween()
		tween.tween_property(self, "transform", transform.rotated_local(Vector3.UP, PI/2), TRAVEL_TIME)
	# wait
	if Input.is_action_pressed("wait"):
		player_step.emit()

func game_over() -> void:
	print("GAME OVER!")
