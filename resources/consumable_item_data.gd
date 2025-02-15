class_name ConsumableItemData
extends ItemData

@export var health_restore: int
@export var energy_restore: int
@export var hunger_restore: int

func use():
	print("using the consumable item")
