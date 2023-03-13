extends Camera2D

# Lower cap for the `_zoom_level`.
@export var min_zoom := 0.5
# Upper cap for the `_zoom_level`.
@export var max_zoom := 2.0
# Controls how much we increase or decrease the `_zoom_level` on every turn of the scroll wheel.
@export var zoom_factor := 0.1
# Duration of the zoom's tween animation.
@export var zoom_duration := 0.2

@export var pan_speed := 15

# The camera's target zoom level.
var _zoom_level := 1.0 : set = _set_zoom_level

# We store a reference to the scene's tween node.
#@onready var tween := get_tree().create_tween()

func _set_zoom_level(value: float) -> void:
	# We limit the value between `min_zoom` and `max_zoom`
	_zoom_level = clamp(value, min_zoom, max_zoom)
	# Then, we ask the tween node to animate the camera's `zoom` property from its current value
	# to the target zoom level.
	
	var tween := get_tree().create_tween()
	tween.tween_property(
		self,
		"zoom",
		Vector2(_zoom_level, _zoom_level),
		zoom_duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

func _unhandled_input(event):
	if GlobalVariables.cameraMovementEnabled:
		if event.is_action_pressed("zoom_in"):
			# Inside a given class, we need to either write `self._zoom_level = ...` or explicitly
			# call the setter function to use it.
			_set_zoom_level(_zoom_level - zoom_factor)
		if event.is_action_pressed("zoom_out"):
			_set_zoom_level(_zoom_level + zoom_factor)

func _process(delta):
	if GlobalVariables.cameraMovementEnabled:
		if Input.is_action_pressed("pan_left"):
			position += Vector2(_zoom_level * -pan_speed,0)
		elif Input.is_action_pressed("pan_right"):
			position += Vector2(_zoom_level * pan_speed,0)
		if Input.is_action_pressed("pan_up"):
			position += Vector2(0, _zoom_level * -pan_speed)
		elif Input.is_action_pressed("pan_down"):
			position += Vector2(0, _zoom_level * pan_speed)
