extends FileDialog

onready var graphManager = get_parent().get_parent().get_parent().get_node("GraphManager")

func _on_SaveProject_file_selected(path):
	graphManager.save_project(path)
