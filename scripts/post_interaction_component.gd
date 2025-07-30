class_name PostInterComponent
extends Area2D

@export var tool: DataTypes.Tools = DataTypes.Tools.None
signal interact

func _on_area_entered(area: Area2D) -> void:
	var pre_inter_component = area as PreInteraction
	if pre_inter_component:
		pre_inter_component.tool_used.connect(_on_tool_used)

func _on_tool_used(tool_used: DataTypes.Tools, dmg: int) -> void:
	print("Tool used signal received: ", tool_used)
	if tool_used == tool:
		print("Tool matches! Emitting interact")
		interact.emit(dmg)
