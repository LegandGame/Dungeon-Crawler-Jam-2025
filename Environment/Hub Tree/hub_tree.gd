extends StaticBody3D


func _on_collection_area_area_entered(area: Area3D) -> void:
	if area.get_parent().is_in_group("player"):
		print("update inventory here in hub_tree")
