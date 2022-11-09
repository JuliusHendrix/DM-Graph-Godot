extends Node2D

class ToolBase:
	extends Node2D
	
	func process_base_event(event, graph_manager, UI_node):
		# handle right click menu
		if event.is_action_pressed('right_click'):
#			UI_node.toggle_mouse_menu(event.position)
			pass

class SelectTool:
	extends ToolBase
	
	func process_event(event, graph_manager, UI_node):
		if event.is_action_pressed("left_click"):
			graph_manager.selected_gnode = graph_manager.above_gnode
		
		self.process_base_event(event, graph_manager, UI_node)

class MoveTool:
	extends ToolBase
	
	# variables
	var mouse_pressed = false
	
	func process_event(event, graph_manager, UI_node):
		# track mouse clicking
		if event.is_action_pressed("left_click"):
			mouse_pressed = true
		elif event.is_action_released("left_click"):
			mouse_pressed=false
		
		# move node
		if event.is_action_pressed("left_click"):
			graph_manager.selected_gnode = graph_manager.above_gnode
		if mouse_pressed:
			if graph_manager.selected_gnode:
				graph_manager.move_gnode(
					graph_manager.background.get_global_mouse_position()
				)

		self.process_base_event(event, graph_manager, UI_node)

# initialize tools
var tools = {
	'select': SelectTool.new(),
	'move': MoveTool.new()
}

func _ready():
	for key in tools:
		self.add_child(tools[key])
