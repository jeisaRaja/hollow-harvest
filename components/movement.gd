class_name PlayerMovementComponent
extends Node

@export var movement_speed: int
@export var player: Player


func _ready():
	pass


func handle_movement() -> Vector2:
	player.velocity = PlayerInput.direction * movement_speed
	player.move_and_slide()
	return PlayerInput.direction
