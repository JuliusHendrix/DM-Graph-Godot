extends Node2D
class_name BaseNode

export var settings : Resource
export var properties : Resource

func get_properties():
	var propertiesDict = {
		"Name": properties.name,
		"Type": properties.type,
		"Position": properties.position
	}
	return propertiesDict

func update_properties():
	# name 
	$TemplateNode.set_label_name(properties.name)
	self.name = properties.name

	# position
	self.position = properties.position

func highlight():
	$Sprite.modulate.a = settings.highlightedAlpha
	$TemplateNode.light_on()

func show():
	$Sprite.modulate.a = settings.highlightedAlpha
	$TemplateNode.light_off()
	
func dim():
	$Sprite.modulate.a = settings.dimmedAlpha
	$TemplateNode.light_off()
