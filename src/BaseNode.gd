extends Node2D

var mouseOver = false

func _on_Visual_mouse_entered():
	mouseOver = true

func _on_Visual_mouse_exited():
	mouseOver = false

func set_label_name(name : String):
	$Information/LabelName.text = name

func light_on():
	$Visual/Sprite.modulate.r = 2.5
	$Visual/Sprite.modulate.g = 2.5
	$Visual/Sprite.modulate.b = 2.5

func light_off():
	$Visual/Sprite.modulate.r = 1
	$Visual/Sprite.modulate.g = 1
	$Visual/Sprite.modulate.b = 1
