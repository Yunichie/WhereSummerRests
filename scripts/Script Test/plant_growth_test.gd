extends Node
class_name PlantGrowthComponent

signal growth_progress_changed(current_progress: float, max_progress: float)
signal plant_fully_grown
signal plant_needs_water
signal plant_needs_planting

@export var max_growth: float = 100.0
@export var watering_increment: float = 20.0
@export var planting_increment: float = 15.0
@export var growth_stages: Array[Texture2D] = [] 

var current_growth: float = 0.0
var is_planted: bool = false
var is_fully_grown: bool = false

var plant_sprite: Sprite2D

func _ready():
	plant_sprite = get_parent().get_node("Sprite2D") if get_parent().has_node("Sprite2D") else null
	if get_parent() is Sprite2D:
		plant_sprite = get_parent()
	elif get_parent().has_node("Sprite2D"):
		plant_sprite = get_parent().get_node("Sprite2D")
		
func water_plant() -> bool:
	if not is_planted or is_fully_grown:
		return false
	
	increase_growth(watering_increment)
	return true

func plant_seed() -> bool:
	if is_planted or is_fully_grown:
		return false
	
	is_planted = true
	increase_growth(planting_increment)
	return true

func increase_growth(amount: float):
	if is_fully_grown:
		return
		
	current_growth = min(current_growth + amount, max_growth)
	growth_progress_changed.emit(current_growth, max_growth)
	
	#update_plant_appearance() sementara tak matiin soale anomaly
	
	if current_growth >= max_growth and not is_fully_grown:
		is_fully_grown = true
		update_plant_appearance()
		plant_fully_grown.emit()
		

func update_plant_appearance():
	if not plant_sprite or growth_stages.is_empty():
		return
	
	var progress_ratio = current_growth / max_growth
	var stage_index = int(progress_ratio * growth_stages.size())
	stage_index = min(stage_index, growth_stages.size() - 1)
	
	if stage_index >= 0 and stage_index < growth_stages.size():
		plant_sprite.texture = growth_stages[1]

func get_growth_percentage() -> float:
	return (current_growth / max_growth) * 100.0

func can_be_watered() -> bool:
	return is_planted and not is_fully_grown

func can_be_planted() -> bool:
	return not is_planted and not is_fully_grown
