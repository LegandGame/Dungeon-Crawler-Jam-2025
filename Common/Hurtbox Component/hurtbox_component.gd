class_name Hurtbox extends Area3D

@onready var hurt_1: AudioStreamPlayer = $Hurt1

signal hurt(value)

func on_hurt(value : int) -> void:
	hurt_1.play()
	hurt.emit(value)
