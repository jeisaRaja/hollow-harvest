class_name PlayerMovementComponent
extends Node

@export var input: InputComponent
@export var movement_speed: int
@export var player: Player


func _ready():
	pass


func handle_movement():
	player.velocity = input.direction * movement_speed
	player.move_and_slide()
