extends Panel

onready var popupWindows = get_parent().get_parent().get_node("PopupWindows")

var graph = null

func display_graph_info(graph):
	# set name
	$Contents/Name.text = graph.name
	
	# display type
	$Contents/Type.text = Utils.type_array_to_string(graph.properties.type)
	$Contents/TabContainer/Nodes.clear_entries()
	for node in graph.nodes:
		$Contents/TabContainer/Nodes.add_entry(node)
	
	self.graph = graph

func update():
	var requested_node = $Contents/TabContainer/Nodes.get_requested()
	if requested_node != null:
		graph.select_node(requested_node)
	
func _on_AddButton_pressed():
	popupWindows.get_node("NewNode").popup()
