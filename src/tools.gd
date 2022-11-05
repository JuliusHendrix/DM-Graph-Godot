class ToolBase:
	extends Node2D
	
	func process_base_event(event, graph_utils):
		pass

class SelectTool:
	extends ToolBase
	
	func process_event(event, graph_utils):
		if event.is_action_pressed("left_click"):
			graph_utils.selected_gnode = graph_utils.above_gnode
		
		self.process_base_event(event, graph_utils)

class MoveTool:
	extends ToolBase
	
	# variables
	var mouse_pressed = false
	
	func process_event(event, graph_utils):
		# track mouse clicking
		if event.is_action_pressed("left_click"):
			mouse_pressed = true
		elif event.is_action_released("left_click"):
			mouse_pressed=false
		
		# move node
		if event.is_action_pressed("left_click"):
			graph_utils.selected_gnode = graph_utils.above_gnode
		if mouse_pressed:
			if graph_utils.selected_gnode:
				graph_utils.move_gnode(get_global_mouse_position())

		self.process_base_event(event, graph_utils)
