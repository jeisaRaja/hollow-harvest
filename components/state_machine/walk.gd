extends State


func enter():
	handle_animation_dir()
	super.enter()


func physics_process(_delta: float):
	handle_animation_dir()
	if character.velocity == Vector2.ZERO:
		transitioned.emit(self, "idle")
