class_name Hotbar
extends PanelContainer

@export var hotbar_item: PackedScene
@onready var hbox = %HBoxContainer as Control


func set_inventory_data(inventory_data: InventoryData) -> void:
	inventory_data.inventory_updated.connect(populate_hotbar)
	populate_hotbar(inventory_data)


func populate_hotbar(inventory_data: InventoryData) -> void:
	for child in hbox.get_children():
		child.queue_free()

	for slot_data in inventory_data.slot_datas.slice(0, 6):
		var new_hotbar_item = hotbar_item.instantiate() as HotbarItem
		hbox.add_child(new_hotbar_item)
		new_hotbar_item.hotbar_item_pressed.connect(_on_hotbar_item_pressed)

		if slot_data:
			new_hotbar_item.set_slot_data(slot_data)


func _on_hotbar_item_pressed(index: int):
	var data = GameplayEvent.slot_datas()[index] as SlotData
	if not data:
		ToolManager.select_item(DataTypes.Items.None)
		return

	ToolManager.select_item(data.item_data.item_type)
