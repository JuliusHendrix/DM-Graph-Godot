extends Panel

var entries : Array = []


func add_entry(node):
	var new_entry = $ScrollContainer/VBoxContainer/Entry.duplicate()
	entries.append(new_entry)
	$ScrollContainer/VBoxContainer.add_child(new_entry)
	new_entry.setup(node)
	new_entry.visible = true

func clear_entries():
	for entry in entries:
		entry.queue_free()
	entries = []

func get_requested():
	for entry in entries:
		if entry.requested:
			entry.requested = false
			return entry.node
	return null

func _on_AddButton_pressed():
	print(get_tree().root)
