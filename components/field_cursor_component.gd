class_name FieldCursorComponent
extends Node

@export var dirt_tilemap_layer: TileMapLayer
@export var tilled_soil_tilemap_layer: TileMapLayer
@export var terrain_set: int = 0
@export var terrain: int = 2

var mouse_position: Vector2
var cell_position: Vector2
var cell_source_id: int
var local_cell_position: Vector2
var distance: float


func _input(event):
	if event.is_action_pressed("hit"):
		if ToolManager.selected_item == DataTypes.Items.TillGround:
			get_cell_under_mouse()
			add_tilled_soil_cell()


func get_cell_under_mouse() -> void:
	mouse_position = dirt_tilemap_layer.get_local_mouse_position()
	cell_position = dirt_tilemap_layer.local_to_map(mouse_position)
	cell_source_id = dirt_tilemap_layer.get_cell_source_id(cell_position)
	local_cell_position = dirt_tilemap_layer.map_to_local(cell_position)
	distance = GameplayEvent.player.global_position.distance_to(local_cell_position)


func add_tilled_soil_cell() -> void:
	if distance < 30.0 and cell_source_id != -1:
		tilled_soil_tilemap_layer.set_cells_terrain_connect(
			[cell_position], terrain_set, terrain, true
		)
