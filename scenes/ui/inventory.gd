extends PanelContainer

const slot = preload("res://scenes/ui/slot.tscn")

@onready var item_grid: GridContainer = %ItemGrid


func _ready():
	GameplayEvent.player_added.connect(_on_player_added)


func _on_player_added():
	set_player_inventory_data(GameplayEvent.player.inventory_data)


func _on_inventory_interacted(inventory_data: InventoryData, index: int, button: int):
	print("%s %s %s" % [inventory_data, index, button])


func set_player_inventory_data(inventory_data: InventoryData):
	inventory_data.inventory_interacted.connect(_on_inventory_interacted)
	populate_item_grid(inventory_data)


func populate_item_grid(inventory_data: InventoryData) -> void:
	for child in item_grid.get_children():
		child.queue_free()

	for slot_data in inventory_data.slot_datas:
		var new_slot = slot.instantiate()
		item_grid.add_child(new_slot)

		new_slot.slot_clicked.connect(inventory_data.on_slot_clicked)

		if slot_data:
			new_slot.set_slot_data(slot_data)
