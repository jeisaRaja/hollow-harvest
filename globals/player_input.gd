extends Node
var direction: Vector2
var movement_locked: bool = false


func _process(_delta):
	if not movement_locked:
		direction = Input.get_vector("left", "right", "up", "down")
	else:
		direction = Vector2.ZERO

	if Input.is_action_just_pressed("inventory"):
		GameplayEvent.inventory_toggled.emit()


func use_tool() -> bool:
	return Input.is_action_just_pressed("hit")


func lock():
	movement_locked = true


func unlock():
	movement_locked = false
