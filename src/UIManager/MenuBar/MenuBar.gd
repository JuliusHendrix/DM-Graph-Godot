extends Panel

onready var newNodeWindow = get_parent().get_node("PopupWindows/NewNode")

func _ready():
	# connect menu options
	var filePopup = $HBoxContainer/File.get_popup()
	
	var graphPopup = $HBoxContainer/Graph.get_popup()
	graphPopup.connect("id_pressed", self, "graph_menu_handler")

func graph_menu_handler(ID):
	match ID:
		1: # switch graph
			print("switch graph")
		2: # add node
			newNodeWindow.popup()
