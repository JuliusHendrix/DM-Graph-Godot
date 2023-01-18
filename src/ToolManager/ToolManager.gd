extends Control

class_name ToolManager

onready var graphManager : GraphManager = get_parent().get_node("GraphManager")

var activeTool

func _unhandled_input(event):
	# use tool
	if GlobalVariables.toolsEnabled:
		if activeTool != null:
			activeTool.process_event(event)

func set_tool(toolName : String) -> bool:
	if not $Tools.tools.has(toolName):
		print("toolName: ", toolName, " not known")
		return false
	
	if toolName == "Connect" && graphManager.selectedGraph.selected_node == null:
		print("No selected node")
		return false
	
	activeTool = $Tools.tools[toolName]
	return true

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

func add_edge_to_hovered_node():
	var hoveredNode = graphManager.selectedGraph.get_hovered_node()
	if hoveredNode == null:
		print("No node clicked")
		return
	
	var newEdge = graphManager.create_edge(["Base"])
	
	newEdge.properties = EdgePropertiesResource.new()
	newEdge.properties.type = ["Base"]
	graphManager.selectedGraph.add_edge(
		newEdge, graphManager.selectedGraph.selected_node, hoveredNode
	)
	graphManager.selectedGraph.update()
