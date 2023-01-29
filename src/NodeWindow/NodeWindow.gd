extends Panel

signal node_selected(node)

var entries : Array = []
var selectedEntry = null

func show_nodes(nodes : Array):
	clear_entries()
	for node in nodes:
		add_entry(node)

func add_entry(node):
	var new_entry = $ScrollContainer/VBoxContainer/Entry.duplicate()
	entries.append(new_entry)
	$ScrollContainer/VBoxContainer.add_child(new_entry)
	new_entry.setup(node)
	new_entry.visible = true

func select_entry(entryToSelect):
	for entry in entries:
		if entry == entryToSelect:
			entry.pressed = true
		else:
			entry.pressed = false
	
	selectedEntry = entryToSelect
	emit_signal("node_selected", entryToSelect.node)

func select_entry_with_node(node):
	for entry in entries:
		if entry.node == node:
			entry.pressed = true
			selectedEntry = entry
		else:
			entry.pressed = false

func deselect_entries():
	for entry in entries:
		entry.pressed = false
	selectedEntry = null

func clear_entries():
	for entry in entries:
		entry.queue_free()
	entries = []

