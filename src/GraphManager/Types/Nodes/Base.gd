extends Node2D

class_name BaseNode

var highlightedAlpha = 1.0
var dimmedAlpha = 0.3

# node parameters
var nodeType : Array = ["Base"]

func set_name(name : String):
	$BaseNode.set_label_name(name)
	self.name = name

func highlight():
	$Sprite.modulate.a = highlightedAlpha

func dim():
	$Sprite.modulate.a = dimmedAlpha
