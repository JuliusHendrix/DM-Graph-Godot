extends BaseEdge

func get_properties():
	var propertiesDict = {
		"Type": properties.type,
		"Weights": properties.weights
	}
	return propertiesDict
