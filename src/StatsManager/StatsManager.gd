extends Control

func get_nodes_weight(nodes, selected_node, graph):
	if graph.edgeType != ["Base", "Weighted"]:
		print("order_nodes_by_weight: Not a weighted graph!")
	
	# get weights
	var weights = []
	
	# NOTE: this will only do outgoing edges
	for node in nodes:
		var edge = graph.get_edge_between_nodes(selected_node, node)
		
		if edge == null:
			# TODO: remove node from list or crash (current behaviour (it's a feature))
			continue
			
		weights.append(edge.properties.weight)
	
	if weights.size() == 0:
		print("order_nodes_by_weight: No edges found!")
		return
	
	return weights

func get_nodes_connectivity(nodes, graph):
	# get connectivities
	var connectivities = []
	for node in nodes:
		connectivities.append(
			graph.get_edges_from_node(node).size() + graph.get_edges_to_node(node).size()
		)
	
	return connectivities


