class_name Slot
extends PanelContainer

signal slot_clicked(index: int, button: int)
@export var tooltip_scene: PackedScene
@onready var texture_rect: TextureRect = $MarginContainer/TextureRect
@onready var quantity_label: Label = $QuantityLabel

var title
var description


func set_slot_data(slot_data: SlotData) -> void:
	var item_data = slot_data.item_data
	texture_rect.texture = item_data.texture

	title = item_data.name
	description = item_data.description

	if slot_data.quantity > 1:
		quantity_label.text = "x%s" % slot_data.quantity
		quantity_label.show()
	else:
		quantity_label.hide()


func _on_gui_input(event: InputEvent):
	if (
		event is InputEventMouseButton
		and (event.button_index == MOUSE_BUTTON_LEFT or event.button_index == MOUSE_BUTTON_RIGHT)
		and event.is_pressed()
	):
		slot_clicked.emit(get_index(), event.button_index)


func _make_custom_tooltip(_for_text):
	if not tooltip_scene:
		printerr("tooltip_scene is not assigned!")
		return null

	var tooltip = tooltip_scene.instantiate() as Tooltip

	tooltip.set_title(title)
	tooltip.set_description(description)

	return tooltip
