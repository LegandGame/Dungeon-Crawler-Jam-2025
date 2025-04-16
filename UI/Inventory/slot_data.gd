extends Resource
class_name SlotData

@export var item_data: ItemData
@export_range(1,10) var quantity: int = 1: set = set_quantity

func set_quantity(value: int) -> void:
	quantity = value
	if quantity >=1 and not item_data.stackable:
		quantity = 1 
