extends Panel

@onready var popupWindows = get_parent().get_parent().get_node("PopupWindows")
@onready var toolbar = get_parent().get_parent().get_node("Toolbar")
@onready var statsManager = get_node("/root/World/StatsManager")

var node = null
var graph = null
var selectedNode = null

func _ready():
	# forward save function
	$Contents/TabContainer/Notes.saveNotesFunc = save_notes

func display_node_info(node, graph):
	if node == null:
		return
	
	$Contents.visible = true

	# set name
	$Contents/HBoxContainer/VBoxContainer/Name.text = node.properties.name
	
	# display type
	$Contents/HBoxContainer/VBoxContainer/Type.text = Utils.type_array_to_string(node.properties.type)
	
	# display connections
	# add sorting options
	var labels = []
	var functions = []
	
	if graph.edgeType == ["Base", "Weighted"]:
		labels.append("Weight")
		functions.append(
			func(): return statsManager.get_nodes_weight(
				graph.get_node_neighbours(node),
				node,
				graph
			)
		)
	
	labels.append("Connectivity")
	functions.append(
		func(): return statsManager.get_nodes_connectivity(graph.get_node_neighbours(node), graph)
	)
	
	$Contents/TabContainer/Connections/NodeWindow.add_option_items(labels, functions)
	
	# display nodes
	$Contents/TabContainer/Connections/NodeWindow.show_nodes(graph.get_node_neighbours(node))
	
	# display notes
	$Contents/TabContainer/Notes.text = node.properties.notes
	
	self.node = node
	self.graph = graph

func clear_display():
	$Contents.visible = false
	
func save_notes(notes : String):
	node.properties.notes = notes
		
func _on_DeleteButton_pressed():
	popupWindows.get_node("DeleteNode").popup()

func _on_AddButton_pressed():
	toolbar._on_ConnectButton_pressed()

func _on_RemoveButton_pressed():
	toolbar._on_DisconnectButton_pressed()
