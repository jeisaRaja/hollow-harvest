extends Resource
class_name InventoryData

signal inventory_interacted(inventory_data: InventoryData, index: int, button: int)
@export var slot_datas: Array[SlotData]


func on_slot_clicked(index: int, button: int):
	inventory_interacted.emit(self, index, button)
