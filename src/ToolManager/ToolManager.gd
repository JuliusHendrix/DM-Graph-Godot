extends Control

class_name ToolManager

onready var graphManager = get_node("/root/World/GraphManager")
onready var uiManager = get_node("/root/World/UIManager")

var activeTool

func _unhandled_input(event):
	print("input")
	# use tool
	if GlobalVariables.toolsEnabled:
		print("toolsEnabled")
		if activeTool != null:
			print("activeTool")
			activeTool.process_event(event)

func set_tool(toolName : String) -> bool:
	if not $Tools.tools.has(toolName):
		print("toolName: ", toolName, " not known")
		return false
	
	if (toolName == "Connect" || toolName == "Disconnect") && graphManager.selectedGraph.selected_node == null:
		print("No selected node")
		return false
	
	activeTool = $Tools.tools[toolName]
	return true

func select_hovered_node():
	if graphManager.selectedGraph != null:
		var hoveredNode = graphManager.selectedGraph.get_hovered_node()
		if hoveredNode != null:
			graphManager.selectedGraph.select_node(hoveredNode)
			uiManager.display_node(hoveredNode, graphManager.selectedGraph)
		else:
			graphManager.selectedGraph.deselect_node()
			uiManager.deselect_node()

func move_selected_node_to_mouse():
	if graphManager.selectedGraph != null:
		graphManager.selectedGraph.move_selected_node_to_mouse()

func add_edge_to_hovered_node():
	var hoveredNode = graphManager.selectedGraph.get_hovered_node()
	if hoveredNode == null:
		print("No node clicked")
		return
	
	var newEdge = graphManager.create_edge(graphManager.selectedGraph.edgeType)
	
	newEdge.properties = EdgePropertiesResource.new()
	newEdge.properties.type = graphManager.selectedGraph.edgeType
	graphManager.selectedGraph.add_edge(
		newEdge, graphManager.selectedGraph.selected_node, hoveredNode
	)
	graphManager.selectedGraph.update()
	graphManager.selectedGraph.select_node(graphManager.selectedGraph.selected_node)
	uiManager.display_node(graphManager.selectedGraph.selected_node, graphManager.selectedGraph)

func remove_edge_to_hovered_node():
	print("remove it bby")
	var hoveredNode = graphManager.selectedGraph.get_hovered_node()
	if hoveredNode == null:
		print("No node clicked")
		return

	graphManager.selectedGraph.remove_edge_between_nodes(
		graphManager.selectedGraph.selected_node, hoveredNode
	)
	graphManager.selectedGraph.update()
	graphManager.selectedGraph.select_node(graphManager.selectedGraph.selected_node)
	uiManager.display_node(graphManager.selectedGraph.selected_node, graphManager.selectedGraph)
	
