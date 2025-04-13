class_name Hitbox extends Area3D

@export var value : int = 1

func _ready() -> void:
	area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area3D) -> void:
	if area is Hurtbox:
		area.on_hurt(value)
