extends Panel

var node = null
var requested = false

func setup(node):
	$Name.text = node.properties.name
	self.name = node.properties.name
	
	$Type.text = node.properties.type[-1]
	
	self.node = node

func _on_SelectButton_pressed():
	requested = true
