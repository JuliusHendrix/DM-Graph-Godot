extends FileDialog

onready var graphManager = get_node("/root/World/GraphManager")
onready var uiManager = get_node("/root/World/UIManager")

func _on_LoadProject_dir_selected(dir):
	graphManager.load_project(dir)
	uiManager.display_graph(graphManager.selectedGraph)
	
