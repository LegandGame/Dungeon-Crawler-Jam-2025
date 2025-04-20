extends Control

@onready var tutorial: Control = $"../Tutorial"
@onready var menu_new: AudioStreamPlayer = $"Menu-New"
@onready var music_exploration: AudioStreamPlayer = $MusicExploration
@onready var button: AudioStreamPlayer = $"../Button"
@onready var option_menu: Control = $"../Option Menu"

func _ready() -> void:
	menu_new.play()

func _on_start_pressed() -> void:
	menu_new.stop()
	button.play()
	music_exploration.play()
	visible = false

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_tutorial_pressed() -> void:
	button.play()
	tutorial.make_visible()

func _on_option_pressed() -> void:
	button.play()
	option_menu.make_visible()
	
