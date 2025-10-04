class_name TerrainCollidersGenerator
extends Node2D

const GROUND_COLLISION = preload("GroundCollision/ground_collision.tscn")

static var _instance: TerrainCollidersGenerator = null

static func get_instance() -> TerrainCollidersGenerator:
	return _instance

func _ready() -> void:
	_instance = self

func generate_terrain_colliders(tile_map_layer : TileMapLayer, tile_size : float = 32) -> void:
	for n : Node2D in get_children():
		remove_child(n)
		n.queue_free()
	for cell : Vector2i in tile_map_layer.get_used_cells():
		if _is_ground(tile_map_layer, cell):
			if !_is_ground(tile_map_layer, cell + Vector2i(-1, 0)):
				var obj : Node2D = GROUND_COLLISION.instantiate()
				obj.global_position = tile_map_layer.global_position + tile_size * Vector2(cell) + Vector2(tile_size/2, tile_size/2)
				call_deferred("add_child", obj)
				var i : int = 1
				while _is_ground(tile_map_layer, cell + Vector2i(i, 0)):
					i += 1
				((obj as StaticBody2D).get_node("CollisionShape2D") as CollisionShape2D).shape.size = Vector2(tile_size * i, tile_size)
				((obj as StaticBody2D).get_node("CollisionShape2D") as CollisionShape2D).position.x = (tile_size * i) / 2.0 - (tile_size / 2)


func _is_ground(tile_map_layer : TileMapLayer, cell : Vector2i) -> bool:
	var source_id : int = tile_map_layer.get_cell_source_id(cell)
	return source_id >= 0
