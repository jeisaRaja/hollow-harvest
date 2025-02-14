class_name Hotbar
extends PanelContainer

@export var slot: PackedScene
@onready var hbox = %HBoxContainer as Control


func set_inventory_data(inventory_data: InventoryData) -> void:
	inventory_data.inventory_updated.connect(populate_hotbar)
	populate_hotbar(inventory_data)


func populate_hotbar(inventory_data: InventoryData) -> void:
	for child in hbox.get_children():
		child.queue_free()

	for slot_data in inventory_data.slot_datas.slice(0, 6):
		var new_slot = slot.instantiate()
		hbox.add_child(new_slot)

		if slot_data:
			new_slot.set_slot_data(slot_data)
