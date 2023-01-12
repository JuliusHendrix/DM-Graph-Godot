extends Control

class_name ToolManager

onready var graphManager : GraphManager = get_parent().get_node("GraphManager")

var activeTool

func _unhandled_input(event):
	# use tool
	if GlobalVariables.toolsEnabled:
		if activeTool != null:
			activeTool.process_event(event)

func set_tool(toolName : String):
	if not $Tools.tools.has(toolName):
		print("toolName: ", toolName, " not known")
		return
	
	activeTool = $Tools.tools[toolName]

func select_node():
	if graphManager.selectedGraph != null:
		var hoveredNode = graphManager.selectedGraph.get_hovered_node()
		if hoveredNode != null:
			graphManager.selectedGraph.select_node(hoveredNode)
		else:
			graphManager.selectedGraph.deselect_node()

func move_selected_node_to_mouse():
	if graphManager.selectedGraph != null:
		graphManager.selectedGraph.move_selected_node_to_mouse()
