class_name Player extends Node3D

const TRAVEL_TIME := 0.3

@onready var rayFront : RayCast3D = $RayCastFront
@onready var rayBack : RayCast3D = $RayCastBack
@onready var rayRight : RayCast3D = $RayCastRight
@onready var rayLeft : RayCast3D = $RayCastLeft
@onready var hurtBox : Hurtbox = $Hurtbox
@onready var health : Health = $Health
@onready var animPlayer : AnimationPlayer = $AnimationPlayer
@onready var punch_1: AudioStreamPlayer = $Punch1

@onready var marker : Marker3D = $markers/Markerforward
var gotoPos := Vector3.ZERO

@export var inventory_data: InventoryData

var tween
var speed : int = 1

# # used to prevent weird shenanigans with attacking while moving (MUST be @export for animation)
@export var is_attacking : bool = false
signal player_step	# might wanna change this to something like "player_turn_end" if have time
signal player_HealthChange
signal update_inventory_visual
signal free_hostage
signal game_over

func _ready() -> void:
	# connect all signals here
	hurtBox.connect("hurt", takeDamage)
	health.setHealth(Globs.MAX_HP)

# -----------
# ACTIONS
# ----------
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
	if Input.is_action_just_pressed("wait"):
		player_step.emit()
	# attack
	if Input.is_action_just_pressed("attack"):
		attack()

func takeDamage(damage :int) -> void:
	health.damage(damage)
	player_HealthChange.emit(health.health, Globs.MAX_HP)
	if health.health <= 0:
		game_over.emit()

func moveForward() -> void:
	if not rayFront.is_colliding():
		gotoPos = marker.position + position
		tween = create_tween()
		tween.tween_property(self, "transform", transform.translated_local(Vector3.FORWARD * speed * Globs.TILEWIDTH), TRAVEL_TIME)
		player_step.emit()

func moveBack() -> void:
	if not rayBack.is_colliding():
		gotoPos = marker.position
		tween = create_tween()
		tween.tween_property(self, "transform", transform.translated_local(Vector3.BACK * speed * Globs.TILEWIDTH), TRAVEL_TIME)
		player_step.emit()

func moveLeft() -> void:
	if not rayLeft.is_colliding():
		gotoPos = marker.position
		tween = create_tween()
		tween.tween_property(self, "transform", transform.translated_local(Vector3.LEFT * speed * Globs.TILEWIDTH), TRAVEL_TIME)
		player_step.emit()

func moveRight() -> void:
	if not rayRight.is_colliding():
		gotoPos = marker.position
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
	punch_1.play()
	animPlayer.play("attack")
	player_step.emit()

# -------------
# INVENTORY
# ------------
func update_inventory(name: String, item: Texture) -> bool:
	for slot in inventory_data.slot_datas:
		if !slot.item_data.texture:
			slot.item_data.texture = item
			slot.item_data.name = name
			update_inventory_visual.emit(inventory_data)
			return true
	return false

func clear_inventory() ->void:
	for slot in inventory_data.slot_datas:
			if slot.item_data.texture:
				print(slot.item_data.name)
				slot.item_data.texture = null
				slot.item_data.name = ""
			
	update_inventory_visual.emit(inventory_data)
			
			
