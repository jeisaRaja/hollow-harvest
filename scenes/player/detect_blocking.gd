extends RayCast2D

var last_object: Sprite2D = null


func _process(_delta):
	if is_colliding():
		var collider = get_collider() as Area2D
		if not is_instance_valid(collider):
			return

		var object = collider.get_parent() as Sprite2D
		if not is_instance_valid(object):
			return

		if object != last_object:
			restore_last_object()
			last_object = object

		if object.global_position.y > get_parent().global_position.y:
			fade_object(object, 0.5)
	else:
		restore_last_object()


func fade_object(object: Sprite2D, alpha: float):
	var tween = get_tree().create_tween()
	tween.tween_property(object, "modulate:a", alpha, 0.3)


func restore_last_object():
	if last_object and is_instance_valid(last_object):
		fade_object(last_object, 1.0)
		last_object = null
	else:
		last_object = null
