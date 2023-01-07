extends Panel

var node = null
var requested = false

func setup(node):
	$Name.text = node.name
	self.name = node.name
	
	$Type.text = node.nodeType[-1]
	
	self.node = node

func _on_SelectButton_pressed():
	requested = true
