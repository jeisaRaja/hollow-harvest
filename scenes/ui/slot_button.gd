class_name SlotButton
extends PanelContainer

@onready var slot = $Slot as Slot


func set_slot_data(slot_data: SlotData):
	slot.set_slot_data(slot_data)
