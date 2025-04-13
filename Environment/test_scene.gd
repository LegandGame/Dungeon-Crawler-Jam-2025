extends Node3D

func _ready():
	$player.player_HealthChange.connect($"HUD/HP UI/HP Bar".update_with_tween)
	$"HUD/Movement UI".movement_UI_Pressed_D.connect($player.moveBack)
	$"HUD/Movement UI".movement_UI_Pressed_U.connect($player.moveForward)
	$"HUD/Movement UI".movement_UI_Pressed_L.connect($player.moveLeft)
	$"HUD/Movement UI".movement_UI_Pressed_R.connect($player.moveRight)
	$"HUD/Movement UI".movement_UI_Pressed_rL.connect($player.rotateLeft)
	$"HUD/Movement UI".movement_UI_Pressed_rR.connect($player.rotateRight)
