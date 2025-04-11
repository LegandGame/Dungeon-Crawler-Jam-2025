class_name Hurtbox extends Area3D

signal hurt(value)

func on_hurt(value : int) -> void:
	print("DEBUG: Hurtbox has been hurt")
	hurt.emit(value)
