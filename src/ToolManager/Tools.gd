extends Node2D

var tools

func _ready():
	tools = {
		"Select": $SelectTool,
		"Move": $MoveTool,
		"Connect": $ConnectTool
	}
