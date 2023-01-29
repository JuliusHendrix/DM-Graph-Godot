extends WindowDialog

onready var types = get_node("/root/World/GraphManager/Types")
var requester = null

func _ready():
	pass

func add_children(parent : TreeItem, subdict):
	for nodeType in subdict:
		var child = $Tree.create_item(parent)
		child.set_text(0, nodeType)
		
		if subdict[nodeType][1] != null:
			add_children(child, subdict[nodeType][1])

func make_tree():
	# populate tree with types
	$Tree.clear()
	var root = $Tree.create_item()
	$Tree.set_hide_root(true)
	add_children(root, types.graphTypes)

func get_type_array(item : TreeItem):
	var typeArray = []
	if item.get_parent() != null:
		typeArray.append_array(get_type_array(item.get_parent()))
	
	if item.get_text(0) != "":
		typeArray.append(item.get_text(0))
	return typeArray
	
func _on_Button_pressed():
	if requester == null:
		print("No requester to send the result to")
	var typeArray = get_type_array($Tree.get_selected())
	self.hide()
	requester.process_nodetype(typeArray)
	requester = null


func _on_GraphTypes_about_to_show():
	make_tree()
