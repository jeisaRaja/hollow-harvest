extends Control
signal slot_data_dropped(slot_data: SlotData)

@onready var player_inventory = $PlayerInventory
@onready var grabbed_slot = $GrabbedSlot
@onready var hotbar = $Hotbar as Hotbar
var grabbed_slot_data: SlotData


func _ready():
	GameplayEvent.player_added.connect(_on_player_added)
	GameplayEvent.inventory_toggled.connect(_on_inventory_toggled)


func _physics_process(_delta):
	if grabbed_slot.visible:
		grabbed_slot.global_position = get_global_mouse_position() + Vector2(5, 5)


func _on_player_added(peer_id):
	var player = GameplayEvent.get_player(peer_id)
	if player and peer_id == multiplayer.get_unique_id():
		set_player_inventory_data(player.inventory_data)
		hotbar.set_inventory_data(player.inventory_data)


func _on_inventory_toggled():
	player_inventory.visible = not player_inventory.visible
	if player_inventory.visible:
		hotbar.hide()
		PlayerInput.lock()
	else:
		hotbar.show()
		PlayerInput.unlock()


func set_player_inventory_data(inventory_data: InventoryData):
	inventory_data.inventory_interacted.connect(_on_inventory_interacted)
	player_inventory.set_player_inventory_data(inventory_data)


func _on_inventory_interacted(inventory_data: InventoryData, index: int, button: int):
	match [grabbed_slot_data, button]:
		[null, MOUSE_BUTTON_LEFT]:
			grabbed_slot_data = inventory_data.grab_slot_data(index)
		[_, MOUSE_BUTTON_LEFT]:
			grabbed_slot_data = inventory_data.drop_slot_data(grabbed_slot_data, index)
		[null, MOUSE_BUTTON_RIGHT]:
			pass
		[_, MOUSE_BUTTON_RIGHT]:
			grabbed_slot_data = inventory_data.drop_single_slot_data(grabbed_slot_data, index)

	update_grabbed_slot()


func update_grabbed_slot():
	if grabbed_slot_data:
		grabbed_slot.show()
		grabbed_slot.set_slot_data(grabbed_slot_data)
	else:
		grabbed_slot.hide()


func _on_gui_input(event: InputEvent):
	if event is InputEventMouseButton and event.is_pressed() and grabbed_slot_data:
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				slot_data_dropped.emit(grabbed_slot_data)
				grabbed_slot_data = null
			MOUSE_BUTTON_RIGHT:
				slot_data_dropped.emit(grabbed_slot_data.create_single_slot_data())
				if grabbed_slot_data.quantity < 1:
					grabbed_slot_data = null

		update_grabbed_slot()
