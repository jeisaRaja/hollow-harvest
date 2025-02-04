class_name Player
extends Character

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

	var dir = movement.handle_movement()
	if dir != Vector2.ZERO:
		last_dir = dir

	# if dir == Vector2.ZERO:
	# 	if last_dir.x != 0:
	# 		anim.play("idle_right" if last_dir.x > 0 else "idle_left")
	# 	else:
	# 		anim.play("idle_down" if last_dir.y > 0 else "idle_up")
	# else:
	# 	if dir.x != 0:
	# 		anim.play("walk_right" if dir.x > 0 else "walk_left")
	# 	else:
	# 		anim.play("walk_down" if dir.y > 0 else "walk_up")


func update_camera_position():
	camera_instance.global_position = global_position


func set_up_camera():
	camera_instance = player_camera.instantiate()
	get_tree().current_scene.add_child.call_deferred(camera_instance)
