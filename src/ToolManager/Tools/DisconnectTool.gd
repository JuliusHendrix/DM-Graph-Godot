extends BaseTool

func _init():
	self.eventLogicDict["disconnect_node"] = disconnect_selected_node

func disconnect_selected_node(event):
	if event.is_action_pressed("left_click"):
		self.toolManager.remove_edge_to_hovered_node()
