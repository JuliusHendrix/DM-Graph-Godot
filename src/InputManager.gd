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
	$ToolManager.tools[UI_node.get_current_tool()].process_event(event)

func update_UI():
	if GlobalVariables.current_graph.selected_node == null:
		UI_node.hide_panel_info()
	else:
		UI_node.show_panel_info(GlobalVariables.current_graph.selected_node)

func _on_ButtonAddNode_pressed():
	print('Add Node!')
