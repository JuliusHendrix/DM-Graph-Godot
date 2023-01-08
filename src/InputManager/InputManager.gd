extends Control

onready var activeTool : BaseTool = $Tools/MoveTool
onready var uiManager : UIManager = $UIManager

func _ready():
	$GraphManager.load_test_graph2()
	$GraphManager.load_test_graph1()
	$UIManager/UI/InfoPlane.show_graph_info_panel(
		$GraphManager.selected_graph,
		$GraphManager.graphs
	)

func _input(event):
	# use tool
	if GlobalVariables.toolsEnabled:
		activeTool.process_event(event)

func _process(_delta):
	update_tool()

func update_tool():
	if uiManager.selectedTool == "select":
		activeTool = $Tools/SelectTool
	elif uiManager.selectedTool == "move":
		activeTool = $Tools/MoveTool

func select_node():
	if $GraphManager.selected_graph != null:
		$GraphManager.selected_graph.select_highlighted_node()
		$GraphManager.selected_graph.highlight_selected_node()
		$GraphManager.selected_graph.update()

func show_selected_node():
	if $GraphManager.selected_graph.selected_node != null:
		$UIManager/UI/InfoPlane.show_selection_panel($GraphManager.selected_graph.selected_node)

func move_selected_node_to_mouse():
	if $GraphManager.selected_graph != null:
		$GraphManager.selected_graph.move_selected_node_to_mouse()
