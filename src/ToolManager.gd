extends Node2D

class ToolBase:
	extends Node2D
	
	func process_base_event(event):
		# handle right click menu
		if event.is_action_pressed('right_click'):
#			UI_node.toggle_mouse_menu(event.position)
			pass

class SelectTool:
	extends ToolBase
	
	func process_event(event):
		if event.is_action_pressed("left_click"):
			if GlobalVariables.above_gnode == null:
				GlobalVariables.current_graph.selected_node = null
			else:
				GlobalVariables.current_graph.set_selected_node(GlobalVariables.above_gnode)
		
		self.process_base_event(event)

class MoveTool:
	extends ToolBase
	
	# variables
	var mouse_pressed = false
	
	func process_event(event):
		# track mouse clicking
		if event.is_action_pressed("left_click"):
			mouse_pressed = true
		elif event.is_action_released("left_click"):
			mouse_pressed=false
		
		# move node
		if event.is_action_pressed("left_click"):
			if GlobalVariables.above_gnode == null:
				GlobalVariables.current_graph.selected_node = null
			else:
				GlobalVariables.current_graph.set_selected_node(GlobalVariables.above_gnode)
				
		if mouse_pressed:
			if GlobalVariables.current_graph.selected_node:
				GlobalVariables.current_graph.selected_node.position = GlobalVariables.current_graph.get_node("Background").get_global_mouse_position()
				GlobalVariables.current_graph.update()

		self.process_base_event(event)

# initialize tools
var tools = {
	'select': SelectTool.new(),
	'move': MoveTool.new()
}

func _ready():
	for key in tools:
		self.add_child(tools[key])
