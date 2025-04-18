extends Area3D

@export var hostage_Name:Texture


func _on_area_entered(area: Area3D) -> void:
	if area.get_parent().is_in_group("player"):
		if area.get_parent().update_inventory(hostage_Name):
			rescue()

func rescue() -> void:
	queue_free()
