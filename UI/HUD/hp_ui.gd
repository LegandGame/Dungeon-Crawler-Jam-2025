extends MarginContainer

@onready var icon_grid: HBoxContainer = $HBoxContainer
const ENERGY_FULL = preload("res://Assets/Icons/energy_full.png")
const ENERGY_EMPTY = preload("res://Assets/Icons/energy_empty.png")
var fullIcon = TextureRect.new()
var emptyIcon = TextureRect.new()

func _ready() -> void:
	fullIcon.texture = ENERGY_FULL
	fullIcon.size = Vector2(10,10)
	emptyIcon.texture = ENERGY_EMPTY
	emptyIcon.size = Vector2(10,10)


func populate_hp_icons (currentHp:int, maxHp:int) -> void:
	var hpLost = maxHp-currentHp 
	#clear HP icons
	for child in icon_grid.get_children():
		child.queue_free()
	#re-draw HP icons
	for n in currentHp:
		icon_grid.add_child(fullIcon.duplicate())
		
	for n in hpLost:
		icon_grid.add_child(emptyIcon.duplicate())
