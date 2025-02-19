class_name Collectable
extends Sprite2D

var slot_data: SlotData


func _ready():
	texture = slot_data.item_data.texture


func _on_area_2d_body_entered(body: Node2D):
	if body is Player:
		body.inventory_data.pick_up_slot_data(slot_data)
		queue_free()
