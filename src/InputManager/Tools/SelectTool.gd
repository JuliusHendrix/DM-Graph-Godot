extends BaseTool

func _init():
	self.eventLogicDict["select_node"] = funcref(self, "select_node")

func select_node(event):
	if event.is_action_pressed("left_click"):
		print("left_click tool")
		self.inputManager.select_node()
		self.inputManager.show_selected_node()
