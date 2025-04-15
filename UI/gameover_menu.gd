extends Control

var _is_gameover:bool = false:
	set(value):
		_is_gameover = value
		get_tree().paused = _is_gameover
		visible = _is_gameover
	
func gameover():
	_is_gameover = true

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_new_game_pressed() -> void:
	_is_gameover = false
	get_tree().reload_current_scene()
