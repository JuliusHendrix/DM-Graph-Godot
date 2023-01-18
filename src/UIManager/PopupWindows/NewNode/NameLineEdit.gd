extends LineEdit

var mouseOver = false

func _on_NameLineEdit_focus_entered():
	GlobalVariables.cameraMovementEnabled = false

func _on_NameLineEdit_focus_exited():
	GlobalVariables.cameraMovementEnabled = true

func _on_NameLineEdit_mouse_entered():
	mouseOver = true

func _on_NameLineEdit_mouse_exited():
	mouseOver = false

func _input(event):
	if event.is_action_pressed("left_click"):
		if not mouseOver:
			self.release_focus()
