extends Node2D

# load resources 
onready var graph_utils = preload("res://src/graph_utils.gd").new()
onready var world_node : Node2D
onready var background_node : Area2D
onready var UI_node : CanvasLayer

# variables
var mouse_pressed = false
 
func _ready():
	# setup nodes
	world_node = self.owner
	background_node = world_node.get_node("Background")
	UI_node = world_node.get_node("UI")
	
	graph_utils.nodes_gdnode = world_node.get_node("GNodes")
	graph_utils.edges_gdnode = world_node.get_node("GEdges")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_UI()
	update_tool()

func _input(event):
	# track mouse clicking
	if event.is_action_pressed("left_click"):
		mouse_pressed = true
	elif event.is_action_released("left_click"):
		mouse_pressed=false
	
	# handle right click menu
	if event.is_action_pressed('right_click'):
		UI_node.toggle_mouse_menu(event.position)
	
	# handle tools
	
	# select tool
	if graph_utils.current_tool == 'select':
		if event.is_action_pressed("left_click"):
			graph_utils.selected_gnode = graph_utils.above_gnode
	
	# move tool
	if graph_utils.current_tool == 'move':
		# move node
		if event.is_action_pressed("left_click"):
			graph_utils.selected_gnode = graph_utils.above_gnode
		if mouse_pressed:
			if graph_utils.selected_gnode:
				graph_utils.move_gnode(get_global_mouse_position())


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
