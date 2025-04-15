extends CanvasLayer

@onready var time_remaining = $TimeRemaining

func _ready() -> void:
	time_remaining.value = 100.0

func update_with_tween(maxTime:int,newTime:int):
	var tween = create_tween()

	var timePercent :float
	timePercent = float(newTime)/float(maxTime) *100.0

	tween.tween_property(time_remaining, "value", timePercent, 0.5)
	tween.play()
