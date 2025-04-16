extends PanelContainer

@onready var texture_rect: TextureRect = $MarginContainer/TextureRect
@onready var quantity: Label = $Quantity


func set_slot_data(slot_data: SlotData) -> void:
	var item_data = slot_data.item_data
	texture_rect.texture = item_data.texture
	if slot_data.quantity > 1:
		quantity.text = "x%s" % slot_data.quantity
		quantity.show()
