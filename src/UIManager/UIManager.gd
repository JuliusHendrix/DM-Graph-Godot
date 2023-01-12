extends Control

class_name UIManager

var toolbar

func _ready():
	select_graph($GraphManager.selectedGraph)
	$UI/Toolbar._on_SelectButton_pressed()

func _process(_delta):
	$UI/InfoPlane.update()

func select_graph(graph):
	$UI/InfoPlane/GraphInfo.display_graph_info(graph)
	$UI/InfoPlane/SelectionInfo.graph = graph
