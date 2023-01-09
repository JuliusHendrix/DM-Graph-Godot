extends Node2D

class_name BaseEdge

# node parameters
var edgeType : Array = ["Base"]

# TODO: global variables?
var highlightedAlpha = 1.0
var dimmedAlpha = 0.3

var highlightedThickness = 3
var dimmedThickness = 2

var color = Color(0, 0, 0, highlightedAlpha)
var thickness = 1.5

func highlight():
	color.a = highlightedAlpha
	thickness = highlightedThickness

func show():
	color.a = highlightedAlpha
	thickness = dimmedThickness

func dim():
	color.a = dimmedAlpha
	thickness = dimmedThickness
