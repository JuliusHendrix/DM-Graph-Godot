extends BaseEdge

func get_properties():
	var propertiesDict = {
		"Type": properties.type,
		"Weight": properties.weight
	}
	return propertiesDict
