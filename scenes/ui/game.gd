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
