class_name Hitbox
extends Area2D

enum HitboxType {
	AXE,
	PICKAXE,
	SHOVEL,
	MELEE_ATTACK,
	RANGE_ATTACK,
	ENEMY_ATTACK,
	ENEMY_RANGE_ATTACK,
}

@export var damage : float  = 10
@export var hitboxType : HitboxType = HitboxType.ENEMY_ATTACK

func _ready() -> void:
	area_entered.connect(_on_area_entered)

func _on_area_entered(hurtbox : Area2D):
	if hurtbox != null:
		if hurtbox is Hurtbox:
			hurtbox.apply_damage(self)
