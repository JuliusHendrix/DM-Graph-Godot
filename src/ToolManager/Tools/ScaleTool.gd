extends BaseTool

func _init():
	self.eventLogicDict["scale_node"] = scale_selected_node

func scale_selected_node(event):
	if event.is_action_pressed("left_click"):
		print("scale node")
