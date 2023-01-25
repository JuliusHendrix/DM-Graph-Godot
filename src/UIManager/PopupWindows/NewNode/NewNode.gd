extends WindowDialog

onready var nodeTypesPopup = get_parent().get_node("NodeTypes")
onready var graphManager = get_parent().get_parent().get_parent().get_node("GraphManager")
onready var uiManager = get_parent().get_parent().get_parent()
onready var moveTool = get_parent().get_parent().get_parent().get_node("ToolManager").get_node("Tools/MoveTool")
onready var toolBar = get_parent().get_parent().get_node("Toolbar")

var type = ["Base"]

func _on_NewNode_about_to_show():
	type = ["Base"]

func _on_TypeButton_pressed():
	nodeTypesPopup.requester = self
	nodeTypesPopup.popup()

func process_nodetype(typeArray : Array):
	$VBoxContainer/TypeButton.text = Utils.type_array_to_string(typeArray)
	type = typeArray

func _on_PlaceButton_pressed():
	var newNode = graphManager.create_node(type)
	newNode.properties = NodePropertiesResource.new()
	newNode.properties.name = $VBoxContainer/NameLineEdit.text
	newNode.properties.type = type
	newNode.properties.position = Vector2(0, 0)
	newNode.update_from_properties()
	graphManager.selectedGraph.add_node(newNode)
	graphManager.selectedGraph.select_node(newNode)
	
	uiManager.rebuild_ui()
	
	# activate move mode
	toolBar._on_MoveButton_pressed()
	moveTool.mouse_pressed = true
	
	self.hide()
