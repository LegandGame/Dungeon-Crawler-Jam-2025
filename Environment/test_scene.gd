extends Node3D

var mouse = Vector2()
var timeRemaining = Globs.TIME_REMAINING_MAX
const DIST = 3

@onready var movementUI := $"HUD/Movement UI"
@onready var player := $player
@onready var inventory: PanelContainer = $HUD/Inventory

func _ready():
	player.player_HealthChange.connect($"HUD/HP UI/HP Bar".update_with_tween)
	player.player_step.connect(reduce_time_remaining)
	movementUI.movement_UI_Pressed_D.connect(player.moveBack)
	movementUI.movement_UI_Pressed_U.connect(player.moveForward)
	movementUI.movement_UI_Pressed_L.connect(player.moveLeft)
	movementUI.movement_UI_Pressed_R.connect(player.moveRight)
	movementUI.movement_UI_Pressed_rL.connect(player.rotateLeft)
	movementUI.movement_UI_Pressed_rR.connect(player.rotateRight)
	inventory.set_inventory_data(player.inventory_data)

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
		$Screens/GameOverMenu.gameover()
	
