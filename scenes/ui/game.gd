extends Node

@export var level_container: Node
@export var level_scene: PackedScene

@export_group("User Interface")
@export var ui: Control
@export var ip_line_edit: LineEdit
@export var status_label: Label
@export var not_connected_ui: Control
@export var host_ui: Control
@export var on_game_ui: Control
@export var inventory_ui: Control

@export_group("Inventory")
@export var collectable: PackedScene


func _ready():
	on_game_ui.hide()
	host_ui.hide()
	multiplayer.connection_failed.connect(_on_connection_failed)
	multiplayer.connected_to_server.connect(_on_connected_to_server)
	multiplayer.server_disconnected.connect(_on_server_disconnected)


func change_level(scene):
	for c in level_container.get_children():
		level_container.remove_child(c)
		c.queue_free()
	level_container.add_child(scene.instantiate())


func _on_server_disconnected():
	show_menu()


func _on_connected_to_server():
	status_label.text = "Connected!"


func _on_start_pressed():
	change_level.call_deferred(level_scene)
	hide_menu.rpc()
	show_on_game_ui.rpc()
	Lobby.game_started = true


@rpc("call_local", "authority", "reliable")
func show_on_game_ui():
	on_game_ui.show()


func _on_join_pressed():
	Lobby.join_game(ip_line_edit.text)
	status_label.text = "Connecting..."
	not_connected_ui.hide()
	if Lobby.game_started:
		on_game_ui.show()


func _on_host_pressed():
	not_connected_ui.hide()
	host_ui.show()
	status_label.text = "Hosting!"
	Lobby.create_game()


func _on_connection_failed():
	not_connected_ui.show()
	status_label.text = "Failed to connect to the server"


@rpc("call_local", "authority", "reliable")
func hide_menu():
	host_ui.hide()
	not_connected_ui.hide()
	on_game_ui.hide()
	status_label.hide()


func show_menu():
	ui.hide()
	not_connected_ui.show()


func _on_player_spawned(peer_id: int):
	print("player spawned: " + str(peer_id))


func _on_inventory_ui_slot_data_dropped(slot_data: SlotData):
	if not slot_data or not slot_data.item_data:
		return

	var item_data_path = slot_data.item_data.resource_path
	var spawn_position = (
		GameplayEvent.get_player(multiplayer.get_unique_id()).position + Vector2(-20, 0)
	)

	instantiate_item.rpc(item_data_path, slot_data.quantity, spawn_position)


@rpc("any_peer", "call_local")
func instantiate_item(item_data_path: String, quantity: int, position: Vector2):
	if item_data_path.is_empty():
		print("Invalid item_data path")
		return

	var item_data = load(item_data_path) as ItemData
	if not item_data:
		print("Failed to load item data from path: ", item_data_path)
		return

	var item_instance = collectable.instantiate() as Collectable
	var slot_data = SlotData.new()
	slot_data.item_data = item_data
	slot_data.quantity = quantity
	item_instance.position = position
	item_instance.slot_data = slot_data

	get_parent().add_child(item_instance)
