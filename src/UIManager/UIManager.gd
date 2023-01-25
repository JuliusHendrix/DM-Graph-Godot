extends Control

class_name UIManager

var toolbar
var uiPaused = false

func _ready():
	select_graph($GraphManager.selectedGraph)
	$UI/Toolbar._on_SelectButton_pressed()

func _process(_delta):
	if not uiPaused:
		$UI/InfoPlane.update()

func select_graph(graph):
	$UI/InfoPlane/GraphInfo.display_graph_info(graph)
	$UI/InfoPlane/SelectionInfo.graph = graph

func rebuild_ui():
	$UI/InfoPlane/GraphInfo.display_graph_info($UI/InfoPlane/GraphInfo.graph)
