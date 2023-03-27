extends Panel

var sender = null
var receiver = null
var graph = null
var edge = null

func _ready():
	self.visible = false

func display_edge_info(sender, receiver, graph):
	self.visible = true
	
	self.sender = sender
	self.receiver = receiver
	self.graph = graph
	
	$VBoxContainer/SenderName.text = sender.properties.name
	$VBoxContainer/ReceiverName.text = receiver.properties.name
	
	# TODO: make generalizable for all edge types
	if graph.edgeType != ["Base", "Weighted"]:
		print("graph edgeType is not weighted")
		return
	
	# find edge
	self.edge = graph.get_edge_between_nodes(sender, receiver)
	$VBoxContainer/HBoxContainer/WeightEdit.value = edge.properties.weight
	$VBoxContainer/Notes.text = self.edge.properties.notes

func _on_weight_edit_value_changed(value):
	self.edge.properties.weight = value

func _on_notes_focus_exited():
	self.edge.properties.notes = $VBoxContainer/Notes.text

func _on_close_button_pressed():
	self.visible = false
