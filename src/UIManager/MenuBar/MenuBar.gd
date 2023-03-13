extends Panel

@onready var newGraphWindow = get_parent().get_node("PopupWindows/NewGraph")
@onready var saveWindow = get_parent().get_node("PopupWindows/SaveProject")
@onready var loadWindow = get_parent().get_node("PopupWindows/LoadProject")
@onready var graphManager = get_node("/root/World/GraphManager")
@onready var uiManager = get_node("/root/World/UIManager")

func _ready():
	# connect menu options
	var filePopup = $HBoxContainer/File.get_popup()
	
	filePopup.add_item("Save Project")
	filePopup.add_item("Load Project")
	
	filePopup.connect("id_pressed", file_menu_handler)
	
	var graphPopup = $HBoxContainer/Graph.get_popup()
	
	graphPopup.add_item("Switch Graph")
	graphPopup.add_item("New Graph")
	
	graphPopup.connect("id_pressed", graph_menu_handler)

func graph_menu_handler(ID):
	match ID:
		0: # switch graph
			print("switch graph")
		1: # add node
			newGraphWindow.popup_centered()

func file_menu_handler(ID):
	match ID:
		0: # save project
			saveWindow.popup_centered()
		1: # load project
			loadWindow.popup_centered()
		2: # new project
			graphManager.new_project()
			uiManager.deselect_graph()
