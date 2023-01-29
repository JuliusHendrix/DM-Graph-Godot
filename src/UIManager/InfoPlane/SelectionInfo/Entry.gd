extends Panel

var node = null
var requested = false

func setup(node):
	$Name.text = node.name
	self.name = node.name
	
	$Type.text = node.properties.type[-1]
	
	self.node = node
