extends State


func enter():
	handle_animation_dir()
	super.enter()


func physics_process(_delta: float):
	if character.current_tool != DataTypes.Tools.None && PlayerInput.use_tool():
		transitioned.emit(self, "chop")
	if character.velocity != Vector2.ZERO:
		transitioned.emit(self, "walk")
