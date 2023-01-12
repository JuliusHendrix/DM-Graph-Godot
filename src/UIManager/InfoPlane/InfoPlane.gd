extends Control

func update():
	$GraphInfo.update()
	$SelectionInfo.update()

func show_selection_panel(node, graph):
	$SelectionInfo.display_node_info(node, graph)

func show_graph_info_panel(graph, graphDict):
	$GraphInfo.display_graph_info(graph)
