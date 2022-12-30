# edge base class
class GEdge:
	extends Node2D
	
	var type = ["GEdge"]
	
#	var sender : GNode
#	var receiver : GNode
	
#	var color : Color = Color(0, 0, 0, 1)
#	var width : float = 1.53

#	func _init(sender, receiver):
#		self.sender = sender
#		self.receiver = receiver
#
#	func _draw():
#		draw_line(sender.position, receiver.position, color, width)

class WeightedEdge:
	extends GEdge
	
	var weight : float = 1.0
	
	func _init():
		self.type.append("WeightedEdge")
