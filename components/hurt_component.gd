class_name HurtComponent
extends Area2D

@export var tool: DataTypes.Tools = DataTypes.Tools.None

signal on_hurt


func _on_area_entered(area: Area2D):
	var hit_component = area as HitComponent
	if tool == hit_component.current_tool:
		on_hurt.emit(hit_component.hit_damage)
