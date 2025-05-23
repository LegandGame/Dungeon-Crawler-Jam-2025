extends Control

@onready var texture_button: TextureButton = $TextureButton
@onready var button: AudioStreamPlayer = $"../Button"

var _is_visible:bool = false:
	set(value):
		_is_visible = value
		visible = _is_visible

func make_visible() -> void:
	_is_visible = true

func _on_texture_button_pressed() -> void:
	button.play()
	_is_visible = false
