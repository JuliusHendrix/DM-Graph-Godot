extends HBoxContainer

@onready var toolmanager = get_node("/root/World/ToolManager")

func depress_all_buttons():
	for button in self.get_children():
		button.button_pressed = false

# TODO: should really make a select_tool() function...
func _on_SelectButton_pressed():
	# set selected tool
	toolmanager.set_tool("Select")
	depress_all_buttons()
	$SelectButton.button_pressed = true

func _on_MoveButton_pressed():
	# set selected tool
	toolmanager.set_tool("Move")
	depress_all_buttons()
	$MoveButton.button_pressed = true

func _on_ConnectButton_pressed():
	if toolmanager.set_tool("Connect"):
		depress_all_buttons()
		$ConnectButton.button_pressed = true
	else:
		$ConnectButton.button_pressed = false

func _on_DisconnectButton_pressed():
	if toolmanager.set_tool("Disconnect"):
		depress_all_buttons()
		$DisconnectButton.button_pressed = true
	else:
		$DisconnectButton.button_pressed = false

