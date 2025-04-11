class_name Health extends Node

@export var maxHealth : int = 10
var curHealth : int

signal health_changed(new_health)
signal health_empty

func _ready() -> void:
	curHealth = maxHealth

func damage(attack : int) -> void:
	print("DEBUG: health changed")
	curHealth -= attack
	clamp(curHealth, 0, maxHealth)
	health_changed.emit(curHealth)
	if curHealth <= 0:
		health_empty.emit()
