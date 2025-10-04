# godot-components
Reusable components for the Godot Engine

1) Add terrain_colliders_generator.tscn to the scene
2) Whenever colliders need to be generated, add:
  TerrainCollidersGenerator.get_instance().generate_terrain_colliders(tile_map_layer)