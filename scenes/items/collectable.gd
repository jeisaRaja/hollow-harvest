class_name Collectable
extends Sprite2D

var slot_data: SlotData


func _ready():
	texture = slot_data.item_data.texture
