extends BaseTool

var mouse_pressed = false

func _init():
	self.eventLogicDict["move_node"] = funcref(self, "move_node")

func move_node(event):
	# track mouse clicking
	if event.is_action_pressed("left_click"):
		mouse_pressed = true
		self.toolManager.select_node()
	elif event.is_action_released("left_click"):
		mouse_pressed = false
	
	# possibly move the selected node
	if mouse_pressed:
		self.toolManager.move_selected_node_to_mouse()
