extends Panel

onready var popupWindows = get_parent().get_parent().get_node("PopupWindows")
onready var selectionInfo = get_parent().get_node("SelectionInfo")

var graph = null

func display_graph_info(graph):
	$Contents.visible = true
	
	# set name
	$Contents/Name.text = graph.properties.name
	
	# display type
	$Contents/Type.text = Utils.type_array_to_string(graph.properties.type)
	
	# display nodes
	$Contents/TabContainer/Nodes/NodeWindow.show_nodes(graph.nodes)
	
	self.graph = graph

func clear_display():
	$Contents.visible = false

func _on_AddButton_pressed():
	popupWindows.get_node("NewNode").popup()

func _on_RemoveButton_pressed():
	var node = $Contents/TabContainer/Nodes/NodeWindow.selectedEntry.node
	if node == null:
		return
	self.graph.select_node(node)
	selectionInfo.display_node_info(node, self.graph)
	popupWindows.get_node("DeleteNode").popup()

func _on_NodeWindow_node_selected(node):
	print("select")
	self.graph.select_node(node)
	selectionInfo.display_node_info(node, self.graph)
