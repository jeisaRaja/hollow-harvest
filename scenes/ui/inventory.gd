extends PanelContainer

const slot = preload("res://scenes/ui/slot.tscn")

@onready var item_grid: GridContainer = %ItemGrid


func _ready():
	print("ready in inventory")
	GameplayEvent.player_added.connect(_on_player_added)


func _on_player_added():
	print("called")
	set_player_inventory_data(GameplayEvent.player.inventory_data)


func set_player_inventory_data(inventory_data: InventoryData):
	populate_item_grid(inventory_data.slot_datas)


func populate_item_grid(slot_datas: Array[SlotData]) -> void:
	for child in item_grid.get_children():
		child.queue_free()

	for slot_data in slot_datas:
		var new_slot = slot.instantiate()
		item_grid.add_child(new_slot)

		if slot_data:
			new_slot.set_slot_data(slot_data)
