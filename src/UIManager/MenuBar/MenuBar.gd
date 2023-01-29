extends Panel

onready var newGraphWindow = get_parent().get_node("PopupWindows/NewGraph")
onready var saveWindow = get_parent().get_node("PopupWindows/SaveProject")
onready var loadWindow = get_parent().get_node("PopupWindows/LoadProject")
onready var graphManager = get_node("/root/World/GraphManager")
onready var uiManager = get_node("/root/World/UIManager")

func _ready():
	# connect menu options
	var filePopup = $HBoxContainer/File.get_popup()
	filePopup.connect("id_pressed", self, "file_menu_handler")
	
	var graphPopup = $HBoxContainer/Graph.get_popup()
	graphPopup.connect("id_pressed", self, "graph_menu_handler")

func graph_menu_handler(ID):
	match ID:
		1: # switch graph
			print("switch graph")
		2: # add node
			newGraphWindow.popup()

func file_menu_handler(ID):
	match ID:
		0: # save project
			saveWindow.popup()
		1: # load project
			loadWindow.popup()
		2: # new project
			graphManager.new_project()
			uiManager.deselect_graph()
