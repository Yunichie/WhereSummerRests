class_name PostInterComponent
extends Area2D

@export var tool: DataTypes.Tools = DataTypes.Tools.None

signal interact


func _on_area_entered(area: Area2D) -> void:
	var pre_inter_component = area as PreInteraction
	
	if tool == pre_inter_component.current_tool:
		interact.emit(pre_inter_component.hit_dmg)
