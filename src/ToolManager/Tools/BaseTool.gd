extends Node2D

class_name BaseTool

@onready var toolManager = self.get_parent().get_parent()

var eventLogicDict = {}

func process_event(event):
	# process all events
	for eventName in eventLogicDict.keys():
		eventLogicDict[eventName].call(event)
