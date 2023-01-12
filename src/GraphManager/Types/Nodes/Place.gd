extends BaseNode

func get_properties():
	var propertiesDict = {
		"Name": properties.name,
		"Type": properties.type,
		"Position": properties.position
	}
	return propertiesDict
