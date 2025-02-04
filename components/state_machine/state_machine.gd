class_name StateMachine
extends Node

@export var character: Character
@export var initial_state: State
@export var anim: AnimationPlayer

var states := {}
var current_state: State


func _ready():
	for child in get_children():
		if not child is State:
			return
		child.character = character
		child.transitioned.connect(_on_transitioned)
		states[child.name.to_lower()] = child

	if initial_state:
		initial_state.enter()
		current_state = initial_state


func _physics_process(delta):
	if current_state:
		current_state.physics_process(delta)


func _on_transitioned(from: State, to: String):
	if from != current_state:
		return
	var new_state: State = states.get(to.to_lower())
	if not new_state:
		return
	if current_state:
		current_state.exit()

	new_state.enter()
	current_state = new_state
