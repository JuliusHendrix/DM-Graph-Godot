extends Control

class_name UIManager

var selectedTool : String

func _ready():
	_on_SelectButton_pressed()

func _process(_delta):
	$UI/InfoPlane.update()

func _on_SelectButton_pressed():
	# set selected tool
	selectedTool = "select"
	
	# depress all buttons
	for button in $UI/Toolbar.get_children():
		button.pressed = false
	
	# press this button
	$UI/Toolbar/SelectButton.pressed = true

func _on_MoveButton_pressed():
	# set selected tool
	selectedTool = "move"
	
	# depress all buttons
	for button in $UI/Toolbar.get_children():
		button.pressed = false
	
	# press this button
	$UI/Toolbar/MoveButton.pressed = true

