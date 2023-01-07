extends Control

func update():
	$GraphInfoPanel.update()
	
	if $GraphInfoPanel.selectedNode != null:
		show_selection_panel($GraphInfoPanel.selectedNode)
		$GraphInfoPanel.selectedNode = null

func show_selection_panel(node):
	$SelectionPanel.display_node_info(node)

func show_graph_info_panel(graph, graphDict):
	$GraphInfoPanel.display_graph_info(graph)
