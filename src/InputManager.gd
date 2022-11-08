extends Node2D

# load resources 
onready var graph_utils = preload("res://src/graph_utils.gd").new()
onready var world_node : Node2D
onready var background_node : Area2D
onready var UI_node : CanvasLayer
onready var Tool_node : Node2D

# variables
var mouse_pressed = false
 
func _ready():
	# setup nodes
	world_node = self.owner
	background_node = world_node.get_node("Background")
	UI_node = world_node.get_node("UI")
	Tool_node = world_node.get_node("ToolDrawer")
	
	graph_utils.nodes_gdnode = world_node.get_node("GNodes")
	graph_utils.edges_gdnode = world_node.get_node("GEdges")
	
	# send tools to UI
	UI_node.initialize_tools(Tool_node.tools)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_UI()
	update_tool()

func _input(event):
	# process tool
	Tool_node.tools[UI_node.get_current_tool()].process_event(event, graph_utils, UI_node)

func load_test_graph():
	# make new graph
	graph_utils.new_graph("Test Graph")
	UI_node.update_current_graph(graph_utils.graph)
	
	# root node
	graph_utils.add_gnode("root")
	
	# add world
	graph_utils.add_gnode("world", "Place", Vector2(100,0), [graph_utils.find_gnode("root", "GNode")])
	graph_utils.add_gnode("world", "Place", Vector2(100,0), [graph_utils.find_gnode("root", "GNode")])   # doesn't add node
	
	# add actor
	graph_utils.add_gnode("Eve", "Actor", Vector2(50,100), [graph_utils.find_gnode("world", "Place")])

func update_UI():
	if graph_utils.selected_gnode == null:
		UI_node.hide_panel_info()
	else:
		UI_node.show_panel_info(graph_utils.selected_gnode)

func update_tool():
	graph_utils.current_tool = UI_node.get_current_tool()
