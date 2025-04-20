extends Control

@onready var texture_button: TextureButton = $TextureButton
@onready var button: AudioStreamPlayer = $"../Button"
@onready var music_on: TextureButton = $musicON
@onready var music_off: TextureButton = $musicOFF
@onready var sfx_on: TextureButton = $sfxON
@onready var sfx_off: TextureButton = $sfxOFF
@onready var start_menu: Control = $"../StartMenu"

var _is_visible:bool = false:
	set(value):
		_is_visible = value
		visible = _is_visible

func make_visible() -> void:
	_is_visible = true

func _on_back_pressed() -> void:
	if !Globs.muteSFX:
		button.play()
	_is_visible = false


func _on_music_on_pressed() -> void:
	music_off.visible = true
	music_on.visible = false
	Globs.muteMusic = true
	start_menu.pauseMusic()


func _on_music_off_pressed() -> void:
	music_off.visible = false
	music_on.visible = true
	Globs.muteMusic = false
	start_menu.playMusic()


func _on_sfx_on_pressed() -> void:
	sfx_off.visible = true
	sfx_on.visible = false
	Globs.muteSFX = true


func _on_sfx_off_pressed() -> void:
	sfx_off.visible = false
	sfx_on.visible = true
	Globs.muteSFX = false
