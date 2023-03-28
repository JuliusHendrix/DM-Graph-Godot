extends Node2D
class_name BaseNode

@export var settings : Resource
@export var properties : Resource

func update_from_properties():
	# name 
	$TemplateNode.set_label_name(properties.name)
	self.name = properties.name

	# position
	self.position = properties.position

func update_to_properties():
	properties.name = self.name
	properties.position = self.position

func highlight():
	$Sprite2D.modulate.a = settings.highlightedAlpha
	$TemplateNode.light_on()

func display():
	$Sprite2D.modulate.a = settings.highlightedAlpha
	$TemplateNode.light_off()
	
func dim():
	$Sprite2D.modulate.a = settings.dimmedAlpha
	$TemplateNode.light_off()

func set_size(size : String):
	if size not in self.properties.nodeSizes:
		print("Node size " + size + " not known")
		return
	
	self.properties.size = size
	self.scale = Vector2(
		self.properties.nodeSizes[size],
		self.properties.nodeSizes[size]
	)

