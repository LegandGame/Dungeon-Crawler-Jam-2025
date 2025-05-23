extends PanelContainer

const SLOT = preload("res://UI/Inventory/slot.tscn")

@onready var item_grid: VBoxContainer = $MarginContainer/VBoxContainer
const BLANK_INVENTORY:InventoryData = preload("res://UI/Inventory/blank_inventory.tres")
	

func set_inventory_data(inventory_data: InventoryData) -> void:
	populate_item_grid(inventory_data.slot_datas)
	
func populate_item_grid(slot_datas: Array[SlotData]) -> void:
	for child in item_grid.get_children():
		child.queue_free()
		
	for slot_data in slot_datas:
		var slot = SLOT.instantiate()
		item_grid.add_child(slot)
		
		if slot_data:
			slot.set_slot_data(slot_data)
