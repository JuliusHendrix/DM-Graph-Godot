extends Panel

signal node_selected(node)

var nodes = []
var values = []

var entries : Array = []
var selectedEntry = null

var sortHighToLow = true

var options = {}

func custom_comparison(arr1, arr2):
	if sortHighToLow:
		return arr1[1] > arr2[1]
	else:
		return arr1[1] < arr2[1]

func show_ordered_nodes():
	clear_entries()
	
	# sort nodes
	if self.nodes.size() != self.values.size():
		print("order_nodes_by_value: nodes and values not of same length!")
		return
	
	# create one array to sort
	var combinedArray = []
	for i in range(nodes.size()):
		combinedArray.append([nodes[i], values[i]])
	
	# sort array
	combinedArray.sort_custom(custom_comparison)
	
	# show nodes
	for nodeValue in combinedArray:
		add_entry(nodeValue[0], nodeValue[1])

func show_nodes(nodes : Array):
	self.nodes = nodes
	self.values = []
	if options.size() == 0:
		# no options set, so a random ordering
		for i in range(nodes.size()):
			self.values.append(i)
		
		# filter_nodes()
		show_ordered_nodes()
	else:
		_on_option_button_item_selected(0)

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

func add_option_items(labels, functions):
	if labels.size() != functions.size():
		print("add_option_items: labels and functions not of same length")
		return
	
	self.options = {}
	$Titles/OptionButton.clear()
	for idx in range(labels.size()):
		$Titles/OptionButton.add_item(labels[idx], idx)
		self.options[idx] = functions[idx]

func _on_sort_button_pressed():
	if sortHighToLow:
		$Titles/SortButton.text = "▲"
		sortHighToLow = false
		show_ordered_nodes()
	else:
		$Titles/SortButton.text = "▼"
		sortHighToLow = true
		show_ordered_nodes()

func _on_option_button_item_selected(index):
	self.values = options[index].call()
	print(self.values)
	# filter_nodes()
	show_ordered_nodes()
