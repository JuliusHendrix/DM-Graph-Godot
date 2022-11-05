extends Node2D

var radius : float
var color : Color
var gnode

# TODO: remove Node2D node?

func _ready():
	# set the collision shape
	var shape = CircleShape2D.new()
	shape.set_radius(radius)
	$Area2D/CollisionShape2D.shape = shape

func _draw():
	# draw the circle
	draw_circle(Vector2(0,0), radius, color)
