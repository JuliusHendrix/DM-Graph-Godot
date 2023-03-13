extends BaseTool

func _init():
	self.eventLogicDict["connect_node"] = connect_selected_node

func connect_selected_node(event):
	if event.is_action_pressed("left_click"):
		self.toolManager.add_edge_to_hovered_node()
