extends Node3D

var mouse = Vector2()
var timeRemaining = Globs.TIME_REMAINING_MAX
var playerHP = Globs.MAX_HP
const DIST = 3

@onready var player := $player
@onready var inventory: PanelContainer = $HUD/Inventory
@onready var hostage: Area3D = $Hostage
@onready var hp_ui: MarginContainer = $"HUD/HP UI"
@onready var hub_tree: StaticBody3D = $Hub_Tree

func _ready():
	hp_ui.populate_hp_icons(playerHP,playerHP)
	player.player_HealthChange.connect(hp_ui.populate_hp_icons)
	player.player_step.connect(reduce_time_remaining)
	player.game_over.connect(game_over)
	player.update_inventory_visual.connect(inventory.set_inventory_data)
	inventory.set_inventory_data(player.inventory_data)
	hub_tree.dump_inventory.connect(player.clear_inventory)
	

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouse = event.position
	if event is InputEventMouseButton:
		if event.pressed == false and event.button_index == MOUSE_BUTTON_LEFT:
			get_mouse_position(mouse)

#Mouse interaction by creating a ray when mouse is clicked and checking if it intersects with anything	
func get_mouse_position(mouse:Vector2):
	var space = get_world_3d().direct_space_state
	var start = get_viewport().get_camera_3d().project_ray_origin(mouse)
	var end = get_viewport().get_camera_3d().project_position(mouse,DIST)
	
	#create ray using start and end
	var params = PhysicsRayQueryParameters3D.create(start,end)
	
	#cast the ray using the space and return the results as a Dictionary
	var result = space.intersect_ray(params)
	if result.is_empty() == false:
		print(result)
		
func reduce_time_remaining():
	timeRemaining -= randi_range(Globs.TIME_REMAINING_LOWER,Globs.TIME_REMAINING_UPPER)
	$HUD.update_with_tween(Globs.TIME_REMAINING_MAX, timeRemaining)
	if timeRemaining <= 0:
		game_over()

func game_over():
	$Screens/GameOverMenu.gameover()
