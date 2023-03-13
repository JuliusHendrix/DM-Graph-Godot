extends Button

var node = null
@onready var nodeWindow = get_parent().get_parent().get_parent()

func setup(node):
	$Name.text = node.properties.name
	self.name = node.properties.name
	$Type.text = node.properties.type[-1]
	self.node = node

func _on_Entry_pressed():
	nodeWindow.select_entry(self)
