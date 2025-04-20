extends Control

@onready var tutorial: Control = $"../Tutorial"
@onready var menu_new: AudioStreamPlayer = $"Menu-New"
@onready var music_exploration: AudioStreamPlayer = $MusicExploration

func _ready() -> void:
	menu_new.play()

func _on_start_pressed() -> void:
	menu_new.stop()
	music_exploration.play()
	visible = false

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_tutorial_pressed() -> void:
	tutorial.make_visible()

func _on_option_pressed() -> void:
	pass # Replace with function body.
