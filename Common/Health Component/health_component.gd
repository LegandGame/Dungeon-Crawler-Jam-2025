class_name Health extends Node
		
var health : int :
	set(value):
		health = value

signal health_changed(new_health)
signal health_empty
	
func setHealth(newHealth) -> void:
	health = newHealth
	
func damage(attack : int) -> void:
	health -= attack
	health_changed.emit(health)
	if health <= 0:
		health_empty.emit()
