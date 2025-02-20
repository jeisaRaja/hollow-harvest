extends Node2D

@export var players_container: Node2D
@export var player_scene: PackedScene
@export var spawn_points: Array[Node2D]
@export var player_spawner: MultiplayerSpawner

var next_spawn_point_index: int = 0


func _ready():
	player_spawner.spawn_function = spawn_player
	if not multiplayer.is_server():
		return

	multiplayer.peer_connected.connect(add_player)
	multiplayer.peer_disconnected.connect(delete_player)

	add_player(1)
	for id in multiplayer.get_peers():
		add_player(id)


func _exit_tree():
	if multiplayer.multiplayer_peer == null:
		return
	if not multiplayer.is_server():
		return
	multiplayer.peer_connected.disconnect(add_player)
	multiplayer.peer_disconnected.disconnect(delete_player)


func spawn_player(id):
	var player_instance = player_scene.instantiate() as Player
	player_instance.name = str(id)
	player_instance.position = get_spawn_point()

	GameplayEvent.add_player(player_instance)

	return player_instance


func add_player(id):
	player_spawner.spawn(id)


func delete_player(id):
	if not players_container.has_node(str(id)):
		return
	players_container.get_node(str(id)).queue_free()


func get_spawn_point() -> Vector2:
	var spawn_point = spawn_points[next_spawn_point_index].position
	next_spawn_point_index += 1
	if next_spawn_point_index >= len(spawn_points):
		next_spawn_point_index = 0

	return spawn_point
