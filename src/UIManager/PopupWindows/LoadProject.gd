extends FileDialog

onready var graphManager = get_parent().get_parent().get_parent().get_node("GraphManager")
onready var uiManager = get_parent().get_parent().get_parent()

func _on_LoadProject_dir_selected(dir):
	uiManager.uiPaused = true
	graphManager.load_project(dir)
	uiManager.select_graph(graphManager.selectedGraph)
	uiManager.uiPaused = false
	
