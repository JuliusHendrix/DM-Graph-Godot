extends CanvasLayer

# imports
const gc = preload("res://src/graph_classes.gd")

func initialize_tools(tools):
	# add tools
	for i in range(tools.size()):
		$PanelToolbar/OptionButtonTools.add_item(tools.keys()[i], i)

func get_current_tool():
	return $PanelToolbar/OptionButtonTools.text

func update_current_graph(graph : gc.Graph):
	$LabelCurrentGraph.text = graph.name

func hide_panel_info():
	$PanelInfo.visible = false

func toggle_mouse_menu(position : Vector2):
	if $PanelRightClickMenu.visible:
		$PanelRightClickMenu.visible = false
	else:
		$PanelRightClickMenu.rect_position = position
		$PanelRightClickMenu.visible = true

func show_panel_info(gnode : gc.GNode):
	$PanelInfo/LabelNodeName.text = gnode.name
	$PanelInfo/LabelNodeType.text = gnode.type[-1]
	$PanelInfo.visible = true

func hide_tool_info():
	$LabelToolInfo.visible = false

func show_tool_info(text : String):
	$LabelToolInfo.text = text
	$LabelToolInfo.visible = true