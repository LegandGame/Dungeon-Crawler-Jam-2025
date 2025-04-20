extends Control

@onready var scene_1: TextureButton = $scene1
@onready var scene_2: TextureButton = $scene2
@onready var scene_3: TextureButton = $scene3
@onready var scene_4: TextureButton = $scene4
@onready var scene_5: TextureButton = $scene5
@onready var scene_6: TextureButton = $scene6
@onready var scene_7: TextureButton = $scene7
@onready var button: AudioStreamPlayer = $"../Button"

var _is_visible:bool = false:
	set(value):
		_is_visible = value
		visible = _is_visible

func make_visible() -> void:
	_is_visible = true

func _on_scene_1_pressed() -> void:
	scene_1.visible = false
	scene_2.visible = true
	if !Globs.muteSFX:
		button.play()

func _on_scene_2_pressed() -> void:
	scene_2.visible = false
	scene_3.visible = true
	if !Globs.muteSFX:
		button.play()


func _on_scene_3_pressed() -> void:
	scene_3.visible = false
	scene_4.visible = true
	if !Globs.muteSFX:
		button.play()


func _on_scene_4_pressed() -> void:
	scene_4.visible = false
	scene_5.visible = true
	if !Globs.muteSFX:
		button.play()


func _on_scene_5_pressed() -> void:
	scene_5.visible = false
	scene_6.visible = true
	if !Globs.muteSFX:
		button.play()


func _on_scene_6_pressed() -> void:
	scene_6.visible = false
	scene_7.visible = true
	if !Globs.muteSFX:
		button.play()


func _on_scene_7_pressed() -> void:
	scene_7.visible = false
	scene_1.visible = true
	if !Globs.muteSFX:
		button.play()
	_is_visible = false
