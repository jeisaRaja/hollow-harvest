class_name PlayerInputComponent
extends InputComponent


func _process(_delta):
	direction = Input.get_vector("left", "right", "up", "down")
