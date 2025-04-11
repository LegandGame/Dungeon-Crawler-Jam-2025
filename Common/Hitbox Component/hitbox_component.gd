class_name Hitbox extends Area3D

@export var value : int = 1


func _on_area_entered(area: Area3D) -> void:
	if area is Hurtbox:
		print("DEBUG: hitbox has hit")
		area.on_hurt(value)
