extends Node

@export var level_container: Node
@export var level_scene: PackedScene

@export_group("User Interface")
@export var ui: Control
@export var ip_line_edit: LineEdit
@export var status_label: Label
@export var not_connected_ui: BoxContainer
@export var host_ui: BoxContainer


func _ready():
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


func _on_join_pressed():
	Lobby.join_game(ip_line_edit.text)
	status_label.text = "Connecting..."
	not_connected_ui.hide()


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
	ui.hide()


func show_menu():
	ui.hide()
	not_connected_ui.show()
