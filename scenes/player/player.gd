class_name Player
extends Character

@export var player_camera: PackedScene
@export var movement: PlayerMovementComponent
@export var hit_component: HitComponent
@export var inventory_data: InventoryData

var owner_id = 1
var camera_instance: Camera2D


func _enter_tree():
	owner_id = name.to_int()
	set_multiplayer_authority(owner_id)
	if owner_id != multiplayer.get_unique_id():
		return
	set_up_camera()


func _ready():
	ToolManager.item_selected.connect(_on_item_selected)


func _on_item_selected(tool: DataTypes.Items):
	current_tool = tool
	hit_component.current_tool = tool


func _process(_delta):
	if multiplayer.multiplayer_peer == null:
		return
	if owner_id != multiplayer.get_unique_id():
		return
	update_camera_position()


func _physics_process(_delta):
	if owner_id != multiplayer.get_unique_id():
		return

	var dir = movement.handle_movement()
	if dir != Vector2.ZERO:
		last_dir = dir


func update_camera_position():
	camera_instance.global_position = global_position


@rpc("any_peer", "call_local")
func set_player_position(_position: Vector2):
	position = _position
	print(position)


func set_up_camera():
	camera_instance = player_camera.instantiate()
	get_tree().current_scene.add_child.call_deferred(camera_instance)
