extends Control


func _ready():
	GameplayEvent.inventory_toggled.connect(_on_inventory_toggled)


func _on_inventory_toggled():
	visible = not visible
	if visible:
		PlayerInput.lock()
	else:
		PlayerInput.unlock()
