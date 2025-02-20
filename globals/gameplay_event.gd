extends Node
signal player_spawned(peer_id)
signal player_added
signal inventory_toggled

var players = {}


func add_player(player: Player):
	var peer_id = int(player.name.to_int())
	players[peer_id] = player
	player_added.emit(peer_id)


func get_player(peer_id: int) -> Player:
	return players.get(peer_id, null)


func slot_datas(peer_id: int):
	var player = get_player(peer_id)
	if player:
		return player.inventory_data.slot_datas
	return null
