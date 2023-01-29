extends WindowDialog

onready var graphTypesPopup = get_parent().get_node("GraphTypes")
onready var graphManager = get_node("/root/World/GraphManager")
onready var uiManager = get_node("/root/World/UIManager")

var type = ["Base"]

func _on_NewNode_about_to_show():
	type = ["Base"]

func _on_TypeButton_pressed():
	graphTypesPopup.requester = self
	graphTypesPopup.popup()

func process_nodetype(typeArray : Array):
	$VBoxContainer/TypeButton.text = Utils.type_array_to_string(typeArray)
	type = typeArray

func _on_PlaceButton_pressed():
	var newGraph = graphManager.create_graph(type)
	newGraph.properties = GraphPropertiesResource.new()
	newGraph.properties.name = $VBoxContainer/NameLineEdit.text
	newGraph.properties.type = type
	newGraph.update_from_properties()
	graphManager.add_graph(newGraph)
	
	uiManager.rebuild_ui()
	
	self.hide()
