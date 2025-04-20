extends Control

@onready var player: Player = $player
@onready var exploration_1: AudioStreamPlayer = $Exploration1
@onready var button: AudioStreamPlayer = $"../Button"

var _is_gameoverWin:bool = false:
	set(value):
		_is_gameoverWin = value
		#get_tree().paused = _is_gameoverWin
		visible = _is_gameoverWin
	
func win():
	_is_gameoverWin = true
	exploration_1.play()


func _on_new_game_pressed() -> void:
	if !Globs.muteSFX:
		button.play()
	_is_gameoverWin = false
	get_tree().reload_current_scene()
	Globs.spiritCounter = 0
	exploration_1.stop()


func _on_quit_pressed() -> void:
	get_tree().quit()
