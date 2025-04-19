extends Control

@onready var tutorial: Control = $"../Tutorial"

func _on_start_pressed() -> void:
	visible = false

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_tutorial_pressed() -> void:
	tutorial.make_visible()

func _on_option_pressed() -> void:
	pass # Replace with function body.
