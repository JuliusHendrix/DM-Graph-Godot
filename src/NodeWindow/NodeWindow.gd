extends Panel

signal node_selected(node)

var nodes = []
var values = []

var entries : Array = []
var selectedEntry = null

var sortHighToLow = true

func custom_comparison(arr1, arr2):
	if sortHighToLow:
		return arr1[1] > arr2[1]
	else:
		return arr1[1] < arr2[1]

func order_nodes_by_value(nodes, values):
	if nodes.size() != values.size():
		print("order_nodes_by_value: nodes and values not of same length!")
		return
	
	# create one array to sort
	var combinedArray = []
	for i in range(nodes.size()):
		combinedArray.append([nodes[i], values[i]])
	
	# sort array
	combinedArray.sort_custom(custom_comparison)
	
	return combinedArray

func show_ordered_nodes():
	clear_entries()
	
	# sort nodes
	var orderedNodesValues = order_nodes_by_value(self.nodes, self.values)
	
	# show nodes
	for nodeValue in orderedNodesValues:
		add_entry(nodeValue[0], nodeValue[1])

func show_nodes(nodes : Array, values : Array):	
	self.nodes = nodes
	self.values = values
	
	show_ordered_nodes()
	
	

func add_entry(node, value):
	var new_entry = $ScrollContainer/VBoxContainer/Entry.duplicate()
	entries.append(new_entry)
	$ScrollContainer/VBoxContainer.add_child(new_entry)
	new_entry.setup(node, value)
	new_entry.visible = true

func select_entry(entryToSelect):
	for entry in entries:
		if entry == entryToSelect:
			entry.button_pressed = true
		else:
			entry.button_pressed = false
	
	selectedEntry = entryToSelect
	emit_signal("node_selected", entryToSelect.node)

func select_entry_with_node(node):
	for entry in entries:
		if entry.node == node:
			entry.button_pressed = true
			selectedEntry = entry
		else:
			entry.button_pressed = false

func deselect_entries():
	for entry in entries:
		entry.button_pressed = false
	selectedEntry = null

func clear_entries():
	for entry in entries:
		entry.queue_free()
	entries = []


func _on_sort_button_pressed():
	if sortHighToLow:
		$Titles/SortButton.text = "▲"
		sortHighToLow = false
		show_ordered_nodes()
	else:
		$Titles/SortButton.text = "▼"
		sortHighToLow = true
		show_ordered_nodes()
