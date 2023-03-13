extends FileDialog

@onready var graphManager = get_node("/root/World/GraphManager")

func _on_SaveProject_file_selected(path):
	graphManager.save_project(path)

func _on_close_requested():
	self.hide()
