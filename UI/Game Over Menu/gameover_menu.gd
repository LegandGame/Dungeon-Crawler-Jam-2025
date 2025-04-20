extends Control

@onready var player: Player = $"../../player"
@onready var button: AudioStreamPlayer = $"../Button"

var _is_gameover:bool = false:
	set(value):
		_is_gameover = value
		visible = _is_gameover
	
func gameover():
	_is_gameover = true

func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_new_game_pressed() -> void:
	button.play()
	_is_gameover = false
	get_tree().reload_current_scene()
	player.clear_inventory()
	Globs.spiritCounter = 0
