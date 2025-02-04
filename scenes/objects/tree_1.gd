extends Sprite2D

@onready var hurt_component: HurtComponent = $HurtComponent
@onready var damage_component: DamageComponent = $DamageComponent


func _ready():
	hurt_component.on_hurt.connect(_on_hurt.rpc)
	damage_component.max_damaged_reached.connect(_on_max_damaged_reached)


@rpc("any_peer", "call_local", "reliable")
func _on_hurt(hit_damage: int) -> void:
	damage_component.apply_damage(hit_damage)
	material.set_shader_parameter("shake_intensity", 1)
	await get_tree().create_timer(0.5).timeout
	material.set_shader_parameter("shake_intensity", 0.0)


# func shake_tree():
# 	damage_component.apply_damage(hit_damage)
# 	material.set_shader_parameter("shake_intensity", 1)
# 	await get_tree().create_timer(0.5).timeout
# 	material.set_shader_parameter("shake_intensity", 0.0)


func _on_max_damaged_reached():
	print("max damage reached")
	queue_free()
