class_name PreInteraction
extends Area2D

signal tool_used(tool: DataTypes.Tools, dmg: int)

@export var current_tool: DataTypes.Tools = DataTypes.Tools.None
@export var hit_dmg: int = 1

func _process(_delta):
	if current_tool == DataTypes.Tools.WaterFlowers and GameInputEvents.use_tool():
		print("Planting tool used!")
		tool_used.emit(current_tool, hit_dmg)
	elif current_tool == DataTypes.Tools.PlantFlowers and GameInputEvents.use_tool():
		print("Seed planted")
		tool_used.emit(current_tool, hit_dmg)
