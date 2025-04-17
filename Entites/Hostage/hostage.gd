extends Area3D

@export var hostage_Name:Texture
signal add_to_inventory


func _on_area_entered(area: Area3D) -> void:
	add_to_inventory.emit(hostage_Name)

func rescue() -> void:
	queue_free()
