extends Control

@onready var tutorial: Control = $"../Tutorial"
@onready var menu_new: AudioStreamPlayer = $"Menu-New"
@onready var music_exploration: AudioStreamPlayer = $MusicExploration
@onready var button: AudioStreamPlayer = $"../Button"
@onready var option_menu: Control = $"../Option Menu"
@onready var start_scene: Control = $"../StartScene"

func _ready() -> void:
	if !Globs.muteMusic:
		menu_new.play()

func _on_start_pressed() -> void:
	menu_new.stop()
	if !Globs.muteSFX:
		button.play()
	if !Globs.muteMusic:
		music_exploration.play()
	start_scene.make_visible()
	visible = false

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_tutorial_pressed() -> void:
	if !Globs.muteSFX:
		button.play()
	tutorial.make_visible()

func _on_option_pressed() -> void:
	if !Globs.muteSFX:
		button.play()
	option_menu.make_visible()
	
func pauseMusic() -> void:
	menu_new.stop()

func playMusic() -> void:
	menu_new.play()
