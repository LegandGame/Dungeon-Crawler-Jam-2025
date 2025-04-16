class_name Player extends Node3D

const TRAVEL_TIME := 0.3
const MAX_HP = 40

@onready var rayFront : RayCast3D = $RayCastFront
@onready var rayBack : RayCast3D = $RayCastBack
@onready var rayRight : RayCast3D = $RayCastRight
@onready var rayLeft : RayCast3D = $RayCastLeft
@onready var hurtBox : Hurtbox = $Hurtbox
@onready var health : Health = $Health
@onready var animPlayer : AnimationPlayer = $AnimationPlayer

@export var inventory_data: InventoryData


var tween
var speed : int = 1
# # used to prevent weird shenanigans with attacking while moving (MUST be @export for animation)
@export var is_attacking : bool = false
signal player_step	# might wanna change this to something like "player_turn_end" if have time
signal player_HealthChange

func _ready() -> void:
	# connect all signals here
	hurtBox.connect("hurt", takeDamage)
	health.setHealth(MAX_HP)
	
func _physics_process(_delta: float) -> void:
	# check that we arent mid action before trying to do another action
	if tween:
		if tween.is_running():
			return
	if is_attacking:
		return
	
	# movement
	if Input.is_action_pressed("move_forward"):
		moveForward()
	if Input.is_action_pressed("move_back"):
		moveBack()
	if Input.is_action_pressed("strafe_left"):
		moveLeft()
	if Input.is_action_pressed("strafe_right"):
		moveRight()
	# rotation
	if Input.is_action_just_pressed("turn_clock"):
		rotateRight()
	if Input.is_action_just_pressed("turn_counter"):
		rotateLeft()
	# wait
	if Input.is_action_pressed("wait"):
		player_step.emit()
	# attack
	if Input.is_action_just_pressed("attack"):
		attack()

func takeDamage(damage :int) -> void:
	health.damage(damage)
	player_HealthChange.emit(MAX_HP,health.health)
	if health.health <= 0:
		get_tree().call_deferred("reload_current_scene")

func moveForward() -> void:
	if not rayFront.is_colliding():
		tween = create_tween()
		tween.tween_property(self, "transform", transform.translated_local(Vector3.FORWARD * speed * Globs.TILEWIDTH), TRAVEL_TIME)
		player_step.emit()

func moveBack() -> void:
	if not rayBack.is_colliding():
		tween = create_tween()
		tween.tween_property(self, "transform", transform.translated_local(Vector3.BACK * speed * Globs.TILEWIDTH), TRAVEL_TIME)
		player_step.emit()

func moveLeft() -> void:
	if not rayLeft.is_colliding():
		tween = create_tween()
		tween.tween_property(self, "transform", transform.translated_local(Vector3.LEFT * speed * Globs.TILEWIDTH), TRAVEL_TIME)
		player_step.emit()

func moveRight() -> void:
	if not rayRight.is_colliding():
		tween = create_tween()
		tween.tween_property(self, "transform", transform.translated_local(Vector3.RIGHT * speed * Globs.TILEWIDTH), TRAVEL_TIME)
		player_step.emit()

func rotateLeft() -> void:
	tween = create_tween()
	tween.tween_property(self, "transform", transform.rotated_local(Vector3.UP, PI/2), TRAVEL_TIME)

func rotateRight() -> void:
	tween = create_tween()
	tween.tween_property(self, "transform", transform.rotated_local(Vector3.UP, -PI/2), TRAVEL_TIME)

func attack() -> void:
	animPlayer.play("attack")
	player_step.emit()
