extends Node2D

class_name BaseNode

# node parameters
var nodeType : Array = ["Base"]

func set_name(name : String):
	$BaseNode.set_label_name(name)
	self.name = name
