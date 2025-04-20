class_name Hurtbox extends Area3D

@onready var hurt1: AudioStreamPlayer = $Hurt1

signal hurt(value)

func on_hurt(value : int) -> void:
	if value >= 1 and !Globs.muteSFX and !hurt1:
		hurt1.play()
	hurt.emit(value)
