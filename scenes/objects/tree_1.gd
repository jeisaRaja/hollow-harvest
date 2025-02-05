extends Sprite2D

@export var log_scene: PackedScene

@onready var hurt_component: HurtComponent = $HurtComponent
@onready var damage_component: DamageComponent = $DamageComponent


func _ready():
	hurt_component.on_hurt.connect(_on_hurt)
	damage_component.max_damaged_reached.connect(_on_max_damaged_reached)


func _on_hurt(hit_damage: int) -> void:
	damage_component.apply_damage(hit_damage)
	material.set_shader_parameter("shake_intensity", 1)
	await get_tree().create_timer(0.5).timeout
	material.set_shader_parameter("shake_intensity", 0.0)


func _on_max_damaged_reached():
	add_log_scene.rpc.call_deferred()
	queue_free()


@rpc("any_peer", "call_local", "reliable")
func add_log_scene() -> void:
	var log_instance = log_scene.instantiate() as Node2D
	log_instance.global_position = global_position
	get_parent().add_child(log_instance)
