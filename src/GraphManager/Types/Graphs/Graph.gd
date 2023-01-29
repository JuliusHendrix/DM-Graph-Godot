extends CanvasItem
class_name BaseGraph

export var properties : Resource

var nodes : Array
var edges : Array

var selected_node = null

# class specific
var edgeType

func _init():
	edgeType = ["Base"]

func update_from_properties():
	self.name = properties.name

func update_to_properties():
	properties.name = self.name

func add_node_to_adjacency_matrix():
	if properties.adjacencyMatrix.size() == 0:
		properties.adjacencyMatrix = []
	# if undirected, we only need the top triangle of the matrix
	for i_col in properties.adjacencyMatrix.size():
		properties.adjacencyMatrix[i_col].append(-1)
		
	var new_column = []
	for i in range(self.nodes.size()):
		new_column.append(-1)
		
	properties.adjacencyMatrix.append(new_column)

func remove_node_from_adjacency_matrix(nodeIdx):
	# remove from columns
	properties.adjacencyMatrix.remove(nodeIdx)
	
	# remove from rows
	for colIdx in range(properties.adjacencyMatrix.size()):
		properties.adjacencyMatrix[colIdx].remove(nodeIdx)

func remove_edge_from_adjacency_matrix(edgeIdx):
	# remove from matrix
	for colIdx in range(properties.adjacencyMatrix.size()):
		for rowIdx in range(properties.adjacencyMatrix[colIdx].size()):
			if properties.adjacencyMatrix[colIdx][rowIdx] == edgeIdx:
				properties.adjacencyMatrix[colIdx][rowIdx] = -1
			elif properties.adjacencyMatrix[colIdx][rowIdx] > edgeIdx:
				properties.adjacencyMatrix[colIdx][rowIdx] -= 1
				

func add_edge_to_adjacency_matrix(
	edge_idx : int,
	sender_idx : int,
	receiver_idx : int
):
	var col_idx = sender_idx
	var row_idx = receiver_idx
	
#	if not self.directed:
#		# need to check if the coordinates fall within the top triangle of the matrix
#		if row_idx > col_idx:
#			col_idx = receiver_idx
#			row_idx = sender_idx
	
	properties.adjacencyMatrix[col_idx][row_idx] = edge_idx

func get_edges_from_from_node(node):
	var nodeIdx = nodes.find(node, 0)
	var sendingEdges = []
	# find sending edges
	for row_idx in range(properties.adjacencyMatrix[nodeIdx].size()):
		if properties.adjacencyMatrix[nodeIdx][row_idx] != -1:
			sendingEdges.append(
				edges[properties.adjacencyMatrix[nodeIdx][row_idx]]
			)
	return sendingEdges

func get_edges_from_to_node(node):
	var nodeIdx = nodes.find(node, 0)
	var receivingEdges = []
	# find receivingEdges edges
	for col_idx in range(properties.adjacencyMatrix[nodeIdx].size()):
		if properties.adjacencyMatrix[col_idx][nodeIdx] != -1:
			receivingEdges.append(
				edges[properties.adjacencyMatrix[col_idx][nodeIdx]]
			)
	return receivingEdges

func get_edge_between_nodes(sender, receiver):
	# check both ways!
	if not sender in nodes:
		print("Node not in nodes: ", sender)
	
	if not receiver in nodes:
		print("Node not in nodes: ", receiver)
	
	var senderIdx = nodes.find(sender)
	var receiverIdx = nodes.find(receiver)
	
	if properties.adjacencyMatrix[senderIdx][receiverIdx] != -1:
		return edges[properties.adjacencyMatrix[senderIdx][receiverIdx]]
	if not properties.directed:
		if properties.adjacencyMatrix[receiverIdx][senderIdx] != -1:
			return edges[properties.adjacencyMatrix[receiverIdx][senderIdx]]
	print("No edge found")
	return null

func get_node_senders(node):
	var nodeIdx = nodes.find(node, 0)
	# find sending nodes
	var sendingNodes = []
	for col_idx in range(properties.adjacencyMatrix[nodeIdx].size()):
		if properties.adjacencyMatrix[col_idx][nodeIdx] != -1:
			sendingNodes.append(nodes[col_idx])
	return sendingNodes

func get_node_receivers(node):
	var nodeIdx = nodes.find(node, 0)
	# find sending nodes
	var receivingNodes = []
	for row_idx in range(properties.adjacencyMatrix[nodeIdx].size()):
		if properties.adjacencyMatrix[nodeIdx][row_idx] != -1:
			receivingNodes.append(nodes[row_idx])
	return receivingNodes

func get_node_neighbours(node):
	var neighbours = []
	neighbours.append_array(get_node_senders(node))
	neighbours.append_array(get_node_receivers(node))
	return neighbours

# add a node and the correspondig edges
func add_node(node):
	# check if node already exists
	if nodes.find(node) != -1:
		print('node already added!')
		return
	
	# add node
	nodes.append(node)
	add_node_to_adjacency_matrix()
	
	# add godot node
	$Nodes.add_child(node)

func remove_node(node):
	if not node in nodes:
		print("Node not in graph: ", node)
		return
	
	# remove from node list
	var nodeIdx = nodes.find(node)
	nodes.remove(nodeIdx)
	remove_node_from_adjacency_matrix(nodeIdx)
	node.queue_free()
	self.update()

func remove_selected_node():
	show_all_nodes()
	show_all_edges()
	remove_node(selected_node)

func add_edge(
	edge,
	sender,
	receiver
):
	# check if sender and receiver exist
	var sender_idx = nodes.find(sender)
	var receiver_idx = nodes.find(receiver)
	
	if sender_idx == -1:
		print('sender not in graph!')
		return
	
	if receiver_idx == -1:
		print('receiver not in graph!')
		return
	
	if sender_idx == receiver_idx:
		print("no self-edges allowed")
		return
	
	# check if the edge is already in the graph
	if edges.find(edge) != -1:
		print('edge already in graph!')
		return
	
	# check if these nodes are already conneceted
	if properties.adjacencyMatrix[sender_idx][receiver_idx] != -1:
		print("these nodes are already connected")
		return
	if properties.directed == false:
		if properties.adjacencyMatrix[receiver_idx][sender_idx] != -1:
			print("these nodes are already connected")
			return
	
	edges.append(edge)
	var edge_idx = edges.find(edge)
	add_edge_to_adjacency_matrix(edge_idx, sender_idx, receiver_idx)
	
	$Edges.add_child(edge)

func remove_edge(edge):
	if not edge in edges:
		print("Edge not in graph: ", edge)
		return
	
	# remove from node list
	var edgeIdx = edges.find(edge)
	edges.remove(edgeIdx)
	remove_edge_from_adjacency_matrix(edgeIdx)
	edge.queue_free()
	self.update()

func remove_edge_between_nodes(sender, receiver):
	var edge = get_edge_between_nodes(sender, receiver)
	remove_edge(edge)

func _draw():
	draw_edges()

func draw_edges():
	for col_idx in range(properties.adjacencyMatrix.size()):
		for row_idx in range(properties.adjacencyMatrix[col_idx].size()):
			if properties.adjacencyMatrix[col_idx][row_idx] == -1:
				continue
				
			var edge = edges[properties.adjacencyMatrix[col_idx][row_idx]]
			draw_line(
				nodes[col_idx].position,
				nodes[row_idx].position,
				edge.color,
				edge.thickness
			)

func show_all_edges():
	for edge in edges:
		edge.show()

func dim_all_edges():
	for edge in edges:
		edge.dim()

func show_edges(shownEdges : Array):
	for edge in shownEdges:
		edge.show()

func highlight_edges(highlightedEdges : Array):
	for edge in highlightedEdges:
		edge.highlight()
	
func show_all_nodes():
	for node in nodes:
		node.show()

func dim_all_nodes():
	for node in nodes:
		node.dim()

func show_nodes(shownNodes : Array):
	for node in shownNodes:
		node.show()

func highlight_nodes(highlightedNodes : Array):
	for node in highlightedNodes:
		node.highlight()

func highlight_selected_node():
	if selected_node == null:
		show_all_nodes()
		show_all_edges()
		return
	
	# light up node, highlight neighbours
	var neighbours = get_node_neighbours(selected_node)
	dim_all_nodes()
	show_nodes(neighbours)
	selected_node.highlight()
	
	# highlight connecting edges
	dim_all_edges()
	highlight_edges(get_edges_from_from_node(selected_node))
	highlight_edges(get_edges_from_to_node(selected_node))

func set_selected_node(node):
	# check if node is in this graph
	if nodes.find(node) == -1:
		print('cannot select node: node not in this graph!')
		return
	
	selected_node = node

func select_node(node):
	set_selected_node(node)
	highlight_selected_node()
	self.update()

func deselect_node():
	self.selected_node = null
	highlight_selected_node()
	self.update()

func get_hovered_node():
	for node in nodes:
		if node.get_node("TemplateNode").mouseOver:
			return node
	return null

func move_selected_node(position : Vector2):
	if selected_node == null:
		return
	selected_node.position = position
	self.update()

func move_selected_node_to_mouse():
	move_selected_node(get_global_mouse_position())
