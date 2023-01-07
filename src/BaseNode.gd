extends Node2D

var mouseOver = false

func _on_Visual_mouse_entered():
	mouseOver = true

func _on_Visual_mouse_exited():
	mouseOver = false

func set_label_name(name : String):
	$Information/LabelName.text = name
