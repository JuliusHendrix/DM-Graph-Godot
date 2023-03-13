extends Control

class_name UIManager

@onready var graphManager = get_node("/root/World/GraphManager")

var toolbar

func _ready():
	$UI/Toolbar._on_SelectButton_pressed()

func display_graph(graph):
	$UI/InfoPlane/GraphInfo.display_graph_info(graph)

func display_node(node, graph):
	$UI/InfoPlane/SelectionInfo.display_node_info(node, graph)
	$UI/InfoPlane/GraphInfo/Contents/TabContainer/Nodes/NodeWindow.select_entry_with_node(node)

func deselect_node():
	$UI/InfoPlane/SelectionInfo.clear_display()
	$UI/InfoPlane/GraphInfo/Contents/TabContainer/Nodes/NodeWindow.deselect_entries()

func deselect_graph():
	$UI/InfoPlane/GraphInfo.clear_display()

func rebuild_ui():
	$UI/InfoPlane/GraphInfo.display_graph_info(graphManager.selectedGraph)
