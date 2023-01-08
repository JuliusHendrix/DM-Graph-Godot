extends Node2D

class_name BaseEdge

# node parameters
var edgeType : Array = ["Base"]

# TODO: global variables?
var highlightedAlpha = 1.0
var dimmedAlpha = 0.3
var alpha = highlightedAlpha

func highlight():
	alpha = highlightedAlpha

func dim():
	alpha = dimmedAlpha
