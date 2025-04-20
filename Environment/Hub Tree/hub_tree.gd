extends StaticBody3D

signal dump_inventory

func _on_collection_area_area_entered(area: Area3D) -> void:
	if area.get_parent().is_in_group("player"):
		dump_inventory.emit()
