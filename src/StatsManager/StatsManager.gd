extends Control

func custom_comparison(arr1, arr2):
	return arr1[1] < arr2[1]

func order_nodes_by_value(nodes, values):
	if nodes.size() != values.size():
		print("order_nodes_by_value: nodes and values not of same length!")
		return
	
	# create one array to sort
	var combinedArray = []
	for i in range(nodes.size()):
		combinedArray.append(
			[nodes[i], values[i]]
		)
	
	# sort array
#	combinedArray.sort_custom(custom_comparison)
	
	# split array
	var orderedNodes = []
	var orderedValues = []
	
	for element in combinedArray:
		orderedNodes.append(element[0])
		orderedValues.append(element[1])
	
	return [orderedNodes, orderedValues] 

func order_nodes_by_weight(graph, nodes, selected_node):
	if graph.edgeType != ["Base", "Weighted"]:
		print("order_nodes_by_weight: Not a weighted graph!")
	
	# create array to sort
	var weights = []
	
	# NOTE: this will only do outgoing edges
	for node in nodes:
		var edge = graph.get_edge_between_nodes(selected_node, node)
		
		if edge == null:
			# TODO: remove node from list or crash (current behaviour)
			continue
			
		weights.append(edge.properties.weight)
	
	if weights.size() == 0:
		print("order_nodes_by_weight: No edges found!")
		return
	
	# sort array
	return order_nodes_by_value(nodes, weights)
	
	# split arrays
	
	var orderedNodes = []
	var orderedWeights = []
	
	return [orderedNodes, orderedWeights]

func order_nodes_by_connectivity(graph, nodes):
	return

func order_nodes_by_distance(graph, nodes, selected_node):
	return

func order_by_connection_strength(graph, nodes):
	return

