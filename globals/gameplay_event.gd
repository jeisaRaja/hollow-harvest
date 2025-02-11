extends Node
signal player_spawned(peer_id)
signal player_added
signal inventory_toggled

var player: Player:
	set = set_player


func set_player(value):
	player = value
	player_added.emit()
	print("calling player added")
