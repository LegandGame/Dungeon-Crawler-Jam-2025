extends Control

@onready var player: Player = $"../../player"
@onready var button: AudioStreamPlayer = $"../Button"

var _is_paused:bool = false:
	set(value):
		_is_paused = value
		get_tree().paused = _is_paused
		visible = _is_paused

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		_is_paused = !_is_paused

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_resume_pressed() -> void:
	if !Globs.muteSFX:
		button.play()
	_is_paused = false

func _on_restart_pressed() -> void:
	if !Globs.muteSFX:
		button.play()
	_is_paused = false
	get_tree().reload_current_scene() 
	player.clear_inventory()
	Globs.spiritCounter = 0
