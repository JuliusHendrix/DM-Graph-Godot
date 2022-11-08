extends Node2D

# load resources 
onready var UI_node : CanvasLayer

# placeholder reference
var graph_manager : Node2D
 
func _ready():
	# setup nodes
	UI_node = self.owner
	
	# send tools to UI
	UI_node.initialize_tools($ToolManager.tools)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_UI()

func _input(event):
	# process tool
	$ToolManager.tools[UI_node.get_current_tool()].process_event(event, graph_manager, UI_node)

func load_test_graph():
	# make new graph
	graph_manager.new_graph("Test Graph")
	UI_node.update_current_graph(graph_manager.graph)
	
	# root node
	graph_manager.add_gnode("root")
	
	# add world
	graph_manager.add_gnode("world", "Place", Vector2(100,0), [graph_manager.find_gnode("root", "GNode")])
	graph_manager.add_gnode("world", "Place", Vector2(100,0), [graph_manager.find_gnode("root", "GNode")])   # doesn't add node
	
	# add actor
	graph_manager.add_gnode("Eve", "Actor", Vector2(50,100), [graph_manager.find_gnode("world", "Place")])
	graph_manager.add_gnode(
		"Adam",
		"Actor",
		Vector2(150,100),
		[
			graph_manager.find_gnode("world", "Place"),
			graph_manager.find_gnode("Eve", "Actor")
		]
	)

func update_UI():
	if graph_manager.selected_gnode == null:
		UI_node.hide_panel_info()
	else:
		UI_node.show_panel_info(graph_manager.selected_gnode)

func _on_ButtonAddNode_pressed():
	print('Add Node!')
