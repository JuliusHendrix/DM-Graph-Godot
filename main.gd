extends Node2D
	
# Called when the node enters the scene tree for the first time.
func _ready():
	$UI/InputManager.graph_manager = $GraphManager
	$UI/InputManager.load_test_graph()
