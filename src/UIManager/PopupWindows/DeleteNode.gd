extends WindowDialog

onready var graphManager = get_parent().get_parent().get_parent().get_node("GraphManager")
onready var uiManager = get_parent().get_parent().get_parent()

func _on_CancelButton_pressed():
	self.hide()

func _on_ConfirmButton_pressed():
	graphManager.selectedGraph.remove_selected_node()
	uiManager.rebuild_ui()
	self.hide()
