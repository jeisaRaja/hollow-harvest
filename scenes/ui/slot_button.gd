class_name HotbarItem
extends Button

@onready var slot = $Slot as Slot
signal hotbar_item_pressed(index: int)

var active: bool = false


func _ready():
	pressed.connect(_on_pressed)


func set_slot_data(slot_data: SlotData):
	slot.set_slot_data(slot_data)


func _on_pressed():
	hotbar_item_pressed.emit(get_index())

