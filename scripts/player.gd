class_name Player
extends CharacterBody2D
@export var current_tool: DataTypes.Tools = DataTypes.Tools.None
@onready var pre_interaction: PreInteraction = $PreInteraction
var player_direction: Vector2
func _ready() -> void:
	ToolManager.tool_selected.connect(on_tool_selected)

func on_tool_selected(tool: DataTypes.Tools) -> void:
	current_tool = tool
	pre_interaction.current_tool = tool

func handle_plant_interaction():
	var plants = get_tree().get_nodes_in_group("plants")
	var nearest_plant = null
	var min_distance = 100.0 
	
	for plant in plants:
		var distance = global_position.distance_to(plant.global_position)
		if distance < min_distance:
			min_distance = distance
			nearest_plant = plant
	
	if nearest_plant:
		nearest_plant.on_interact(self)
