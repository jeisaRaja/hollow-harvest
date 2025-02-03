class_name Player
extends CharacterBody2D

@export var player_camera: PackedScene
@export var movement: PlayerMovementComponent

var owner_id = 1
var camera_instance: Camera2D


func _enter_tree():
	owner_id = name.to_int()
	set_multiplayer_authority(owner_id)
	if owner_id != multiplayer.get_unique_id():
		return
	set_up_camera()


func _process(_delta):
	if multiplayer.multiplayer_peer == null:
		return
	if owner_id != multiplayer.get_unique_id():
		return
	update_camera_position()


func _physics_process(_delta):
	if owner_id != multiplayer.get_unique_id():
		return
	movement.handle_movement()


func update_camera_position():
	camera_instance.global_position = global_position


func set_up_camera():
	camera_instance = player_camera.instantiate()
	get_tree().current_scene.add_child.call_deferred(camera_instance)
