extends Node2D

var nodeTypes;
var edgeTypes;
var graphTypes;

func _ready():
	nodeTypes = {
		"Base": [$Nodes/Base, {
			"Root": [$Nodes/Root, null],
			"Place": [$Nodes/Place, null],
			"Actor": [$Nodes/Actor, null] 
		}]
	}

	edgeTypes = {
		"Base": [$Edges/Base, {
			"Weighted": [$Edges/Weighted, null]
		}]
	}

	graphTypes = {
		"Base": [$Graphs/Base, {
			"Weighted": [$Graphs/Weighted, null]
		}]
	}
