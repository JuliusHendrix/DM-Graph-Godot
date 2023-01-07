extends VBoxContainer

func add_entry(name : String):
	var new_entry = $GraphEntry.duplicate()
	self.add_child(new_entry)
	new_entry.set_name(name)
	new_entry.visible = true

func clear_entries():
	for entry in self.get_children():
		if entry.name != "GraphEntry":
			entry.queue_free()
