extends WindowDialog

onready var graphManager = get_node("/root/World/GraphManager")
onready var uiManager = get_node("/root/World/UIManager")

func _on_CancelButton_pressed():
	self.hide()

func _on_ConfirmButton_pressed():
	graphManager.selectedGraph.remove_selected_node()
	uiManager.rebuild_ui()
	self.hide()
