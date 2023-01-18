extends Node

func type_array_to_string(typeArray):
	# display type
	var typeString = ""
	for type in typeArray:
		typeString += "/"
		typeString += type
	return typeString
