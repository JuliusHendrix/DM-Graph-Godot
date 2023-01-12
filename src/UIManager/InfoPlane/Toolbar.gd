extends HBoxContainer

onready var toolmanager : ToolManager = get_parent().get_parent().get_node("ToolManager")

func depress_all_buttons():
	for button in self.get_children():
		button.pressed = false
	
func _on_SelectButton_pressed():
	# set selected tool
	toolmanager.set_tool("Select")
	depress_all_buttons()
	$SelectButton.pressed = true

func _on_MoveButton_pressed():
	# set selected tool
	toolmanager.set_tool("Move")
	depress_all_buttons()
	$MoveButton.pressed = true
