extends TextEdit

var mouse_over = false
var saveNotesFunc

func _input(event):
	if event.is_action_pressed("left_click"):
		if not mouse_over:
			self.release_focus()

func _on_Notes_focus_entered():
	GlobalVariables.cameraMovementEnabled = false

func _on_Notes_focus_exited():
	GlobalVariables.cameraMovementEnabled = true
	saveNotesFunc.call(self.text)

func _on_Notes_mouse_entered():
	mouse_over = true

func _on_Notes_mouse_exited():
	mouse_over = false
