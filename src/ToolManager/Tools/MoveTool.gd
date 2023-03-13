extends BaseTool

var mouse_pressed = false

func _init():
	self.eventLogicDict["move_node"] = move_node

func move_node(event):
	# track mouse clicking
	if event.is_action_pressed("left_click"):
		mouse_pressed = true
		self.toolManager.select_hovered_node()
	elif event.is_action_released("left_click"):
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)
		mouse_pressed = false
	
	# possibly move the selected node
	if mouse_pressed:
		Input.set_default_cursor_shape(Input.CURSOR_DRAG)
		self.toolManager.move_selected_node_to_mouse()
