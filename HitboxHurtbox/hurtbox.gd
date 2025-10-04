class_name Hurtbox
extends Area2D

enum HurtboxType {
	PLAYER,
	ENEMY,
	WOOD,
	ORE,
}

#_on_damage_taken
#_on_death

@export var health : float = 100
@export var max_health : float = 100
@export var hurtboxType : HurtboxType = HurtboxType.ENEMY

func apply_damage(hitbox : Hitbox) -> void:
	if hitbox == null:
		return
	health -= hitbox.damage
	if owner.has_method("_on_damage_taken"):
		owner._on_damage_taken(hitbox)
	if health <= 0:
		if owner.has_method("_on_death"):
			owner._on_death(hitbox)
		else:
			owner.queue_free()
