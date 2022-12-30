extends Node2D
	
# Called when the node enters the scene tree for the first time.
func _ready():
	$UI/InputManager.graph_manager = $GraphManager
	$GraphManager.load_test_graph()
	$UI.update_current_graph()
