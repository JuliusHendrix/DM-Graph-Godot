extends Button

var node = null
var value = null
@onready var nodeWindow = get_parent().get_parent().get_parent()

func setup(node, value):
	$Name.text = node.properties.name
	self.name = node.properties.name
	$Type.text = node.properties.type[-1]
	self.value = value
	$Value.text = str(value)
	self.node = node

func _on_Entry_pressed():
	nodeWindow.select_entry(self)
