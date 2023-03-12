extends BaseEdge

func get_properties():
	var propertiesDict = {
		"Type": properties.type,
		"Weight Names": properties.weightNames,
		"Weights": properties.weights
	}
	return propertiesDict
