extends State

@export var hit_component_collision_shape: CollisionShape2D


func _ready():
	hit_component_collision_shape.disabled = true
	hit_component_collision_shape.position = Vector2.ZERO


func enter():
	PlayerInput.lock()
	handle_animation_dir()
	super.enter()
	hit_component_collision_shape.position = get_hitbox_pos(Vector2(15, 5))
	hit_component_collision_shape.disabled = false


func physics_process(_delta: float):
	if PlayerInput.use_tool():
		character.anim.play(animation_name + animation_dir)
	if character.anim.is_playing():
		return
	transitioned.emit(self, "idle")


func exit():
	hit_component_collision_shape.disabled = true
	PlayerInput.unlock()
