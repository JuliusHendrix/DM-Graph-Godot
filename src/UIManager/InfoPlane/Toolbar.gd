extends HBoxContainer

onready var toolmanager = get_node("/root/World/ToolManager")

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

func _on_ConnectButton_pressed():
	if toolmanager.set_tool("Connect"):
		depress_all_buttons()
		$ConnectButton.pressed = true
	else:
		$ConnectButton.pressed = false

func _on_DisconnectButton_pressed():
	if toolmanager.set_tool("Disconnect"):
		depress_all_buttons()
		$DisconnectButton.pressed = true
	else:
		$DisconnectButton.pressed = false
