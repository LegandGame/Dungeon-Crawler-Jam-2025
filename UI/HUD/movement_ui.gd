extends GridContainer

signal movement_UI_Pressed_U
signal movement_UI_Pressed_D
signal movement_UI_Pressed_L
signal movement_UI_Pressed_R
signal movement_UI_Pressed_rL
signal movement_UI_Pressed_rR

func _ready():
	# Connect to the "pressed" signal of the button
	$Turn_L.pressed.connect(turnL_button_pressed)
	$Up.pressed.connect(up_button_pressed)
	$Turn_R.pressed.connect(turnR_button_pressed)
	$Left.pressed.connect(left_button_pressed)
	$Down.pressed.connect(down_button_pressed)
	$Right.pressed.connect(right_button_pressed)

func turnL_button_pressed():
	movement_UI_Pressed_rL.emit()
func up_button_pressed():
	movement_UI_Pressed_U.emit()
func turnR_button_pressed():
	movement_UI_Pressed_rR.emit()
func left_button_pressed():
	movement_UI_Pressed_L.emit()
func down_button_pressed():
	movement_UI_Pressed_D.emit()
func right_button_pressed():
	movement_UI_Pressed_R.emit()
