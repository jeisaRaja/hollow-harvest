extends Sprite2D
class_name Collectable

var slot_data: SlotData


func _ready():
	if slot_data and slot_data.item_data:
		texture = slot_data.item_data.texture


func _on_area_2d_body_entered(body: Node2D):
	if body is Player and body.is_multiplayer_authority():
		body.inventory_data.pick_up_slot_data(slot_data)
		remove_collectable.rpc()


@rpc("any_peer", "call_local")
func remove_collectable():
	queue_free()
