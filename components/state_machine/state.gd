class_name State
extends Node

signal transitioned(from: State, to: String)

@export var animation_name: String
var animation_dir: String
var character: Character
var directions = ["_right", "_left", "_down", "_up"]


func enter():
	character.anim.play(animation_name + animation_dir)


func exit():
	pass


func process(delta: float):
	pass


func physics_process(delta: float):
	pass


func handle_animation_dir():
	var dir_index = 0

	if character.last_dir.x > 0:
		dir_index = 0  # "_right"
	elif character.last_dir.x < 0:
		dir_index = 1  # "_left"
	elif character.last_dir.y > 0:
		dir_index = 2  # "_down"
	elif character.last_dir.y < 0:
		dir_index = 3  # "_up"

	if animation_dir != directions[dir_index]:
		animation_dir = directions[dir_index]

	character.anim.play(animation_name + animation_dir)
