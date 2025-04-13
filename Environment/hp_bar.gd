extends ProgressBar

@onready var progress_bar = $"."

func update_with_tween(maxHP:int,newHP:int):
	var tween = create_tween()

	var hpPercent :float
	hpPercent = float(newHP)/float(maxHP) *100.0

	tween.tween_property(progress_bar, "value", hpPercent, 0.5)
	tween.play()
