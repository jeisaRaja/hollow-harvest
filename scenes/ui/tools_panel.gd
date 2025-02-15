extends PanelContainer


func _on_item_till_pressed():
	ToolManager.select_item(DataTypes.Items.TillGround)


func _on_item_pickaxe_pressed():
	ToolManager.select_item(DataTypes.Items.PickAxe)


func _on_item_axe_pressed():
	ToolManager.select_item(DataTypes.Items.AxeWood)
