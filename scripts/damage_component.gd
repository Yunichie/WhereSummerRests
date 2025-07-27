class_name DamageComponent
extends Node2D

@export var max_dmg =3
@export var current_dmg = 0

signal max_dmg_reached

func apply_dmg(dmg: int) -> void:
	current_dmg = clamp(current_dmg + dmg, 0, max_dmg)
	
	if current_dmg == max_dmg:
		max_dmg_reached.emit()
