extends Panel

func display_node_info(node):
	# set name
	$OverviewContainer/Name.text = node.name
	
	# display type
	var typeString = ""
	for type in node.nodeType:
		typeString += "/"
		typeString += type
	$OverviewContainer/Type.text = typeString

