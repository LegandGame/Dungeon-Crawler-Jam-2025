extends Area3D

@export var hostage_Name:String
@export var hostage_Texture:Texture

func _on_area_entered(area: Area3D) -> void:
	if area.get_parent().is_in_group("player"):
		if area.get_parent().update_inventory(hostage_Name,hostage_Texture):
			rescue()

func rescue() -> void:
	queue_free()
