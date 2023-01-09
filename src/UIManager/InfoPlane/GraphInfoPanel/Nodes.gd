extends VBoxContainer

var entries : Array

func add_entry(node):
	var new_entry = $NodeEntry.duplicate()
	entries.append(new_entry)
	self.add_child(new_entry)
	new_entry.setup(node)
	new_entry.visible = true

func clear_entries():
	for entry in entries:
		entry.queue_free()

func get_requested():
	for entry in entries:
		if entry.requested:
			entry.requested = false
			return entry.node
	return null