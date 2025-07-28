extends PanelContainer

@onready var tool_watering_can: Button = $MarginContainer/HBoxContainer/ToolWateringCan
@onready var tool_plant: Button = $MarginContainer/HBoxContainer/ToolPlant



func _on_tool_watering_can_pressed() -> void:
	ToolManager.select_tool(DataTypes.Tools.WaterFlowers)
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("release_tool"):
		ToolManager.select_tool(DataTypes.Tools.None)
		tool_watering_can.release_focus()
