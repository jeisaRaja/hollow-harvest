extends Node

var selected_item: DataTypes.Items = DataTypes.Items.None

signal item_selected(item: DataTypes.Items)


func select_item(item: DataTypes.Items):
	item_selected.emit(item)
	selected_item = item
