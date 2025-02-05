extends PanelContainer


func _on_tool_till_pressed():
	ToolManager.select_tool(DataTypes.Tools.TillGround)


func _on_tool_pickaxe_pressed():
	ToolManager.select_tool(DataTypes.Tools.PickAxe)


func _on_tool_axe_pressed():
	ToolManager.select_tool(DataTypes.Tools.AxeWood)
