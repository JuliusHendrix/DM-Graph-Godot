extends CanvasItem

var directed : bool = false

var nodes : Array
var edges : Array
var adjacency_matrix = []

var selected_node = null

var graphType = ["Base"]

func expand_adjacency_matrix():
	if self.directed:
		# if directed, we need to expand all columns
		# if undirected, we only need the top triangle of the matrix
		for i_col in self.adjacency_matrix.size():
			self.adjacency_matrix[i_col].append(-1)
		
	var new_column = []
	for i in range(self.nodes.size()):
		new_column.append(-1)
		
	self.adjacency_matrix.append(new_column)

func update_adjacency_matrix(
	edge_idx : int,
	sender_idx : int,
	receiver_idx : int
):
	var col_idx = sender_idx
	var row_idx = receiver_idx
	
	if not self.directed:
		# need to check if the coordinates fall within the top triangle of the matrix
		if row_idx > col_idx:
			col_idx = receiver_idx
			row_idx = sender_idx
	
	self.adjacency_matrix[col_idx][row_idx] = edge_idx
	
# add a node and the correspondig edges
func add_node(node):

	# check if node already exists
	if nodes.find(node) != -1:
		print('node already added!')
		return
	
	# add node
	nodes.append(node)
	expand_adjacency_matrix()
	
	# add godot node
	$Nodes.add_child(node)

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
		
	# check if the edge is already in the graph
	if edges.find(edge) != -1:
		print('edge already in graph!')
		return
	
	edges.append(edge)
	var edge_idx = edges.find(edge)
	update_adjacency_matrix(edge_idx, sender_idx, receiver_idx)
	
	$Edges.add_child(edge)

func _draw():
	draw_edges()

func draw_edges():
	for col_idx in range(adjacency_matrix.size()):
		for row_idx in range(adjacency_matrix[col_idx].size()):
			if adjacency_matrix[col_idx][row_idx] != -1:
				draw_line(
					nodes[col_idx].position,
					nodes[row_idx].position,
					Color(0, 0, 0, 1),
					1.53
				)

func set_selected_node(node):
	# check if node is in this graph
	if nodes.find(node) == -1:
		print('cannot select node: node not in this graph!')
		return
	
	selected_node = node

func select_highlighted_node():
	for node in nodes:
		if node.get_node("BaseNode").mouseOver:
			set_selected_node(node)
			return
	selected_node = null

func move_selected_node(position : Vector2):
	if selected_node == null:
		return
	selected_node.position = position
	self.update()

func move_selected_node_to_mouse():
	move_selected_node(get_global_mouse_position())
