extends Node2D

@export var nodeSettings : Resource

var mouseOver = false

func _on_Visual_mouse_entered():
	mouseOver = true
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func _on_Visual_mouse_exited():
	mouseOver = false
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)

func set_label_name(name : String):
	$Information/LabelName.text = name

func light_on():
	$Visual/Sprite2D.modulate = nodeSettings.lightOnColor

func light_off():
	$Visual/Sprite2D.modulate = nodeSettings.lightOffColor
