extends PanelContainer

const slot = preload("res://scenes/ui/slot.tscn")

@onready var item_grid: GridContainer = %ItemGrid


func _ready():
	var inv_data = preload("res://components/inventory.tres")
	populate_item_grid(inv_data.slot_datas)


func populate_item_grid(slot_datas: Array[SlotData]) -> void:
	print(slot_datas)
	for child in item_grid.get_children():
		child.queue_free()

	for slot_data in slot_datas:
		var new_slot = slot.instantiate()
		item_grid.add_child(new_slot)

		if slot_data:
			new_slot.set_slot_data(slot_data)
