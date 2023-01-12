extends Node2D
class_name BaseEdge

export var settings : Resource
export var properties : Resource

var color : Color = Color(0, 0, 0, 1)
var thickness : float = 1.5

func get_properties():
	var propertiesDict = {
		"Type": properties.type
	}
	return propertiesDict

func highlight():
	color.a = settings.highlightedAlpha
	thickness = settings.highlightedThickness

func show():
	color.a = settings.highlightedAlpha
	thickness = settings.dimmedThickness

func dim():
	color.a = settings.dimmedAlpha
	thickness = settings.dimmedThickness
