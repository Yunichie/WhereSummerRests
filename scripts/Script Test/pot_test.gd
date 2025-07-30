extends Sprite2D

@onready var post_interaction: PostInterComponent = $PostInteraction
@onready var damage_component: DamageComponent = $DamageComponent
@onready var growth_component: PlantGrowthComponent = $PlantGrowth
@onready var progress_bar: ProgressBar = $ProgressBar

@export var Type: String = "Plant"

func _ready() -> void:
	post_interaction.interact.connect(on_interact)
	damage_component.max_dmg_reached.connect(on_max_dmg_reached)
	
	growth_component.growth_progress_changed.connect(on_growth_changed)
	growth_component.plant_fully_grown.connect(on_plant_fully_grown)
	
	add_to_group("plants")
	
	setup_progress_bar()
	
	call_deferred("setup_interaction_tools")

func setup_interaction_tools():
	if post_interaction:
		call_deferred("_deferred_set_tool")

func _deferred_set_tool():
	if not growth_component.is_planted:
		post_interaction.tool = DataTypes.Tools.PlantFlowers
	elif not growth_component.is_fully_grown:
		post_interaction.tool = DataTypes.Tools.WaterFlowers
	else:
		post_interaction.tool = DataTypes.Tools.None

func setup_progress_bar():
	if progress_bar:
		progress_bar.min_value = 0
		progress_bar.max_value = growth_component.max_growth
		progress_bar.value = growth_component.current_growth
		progress_bar.visible = true

func on_interact(hit_dmg: int) -> void:
	var current_tool = post_interaction.tool
	var tool_used = false
	print("Interacted with plant, current tool:", current_tool)

	if current_tool == DataTypes.Tools.PlantFlowers:
		if growth_component.can_be_planted():
			if growth_component.plant_seed():
				show_feedback("Seed planted 🌱")
				tool_used = true
				call_deferred("setup_interaction_tools")
			else:
				show_feedback("Cannot plant here")
		else:
			if growth_component.is_planted:
				show_feedback("Already planted, try watering instead 💧")
				call_deferred("setup_interaction_tools")

	elif current_tool == DataTypes.Tools.WaterFlowers:
		if growth_component.can_be_watered():
			if growth_component.water_plant():
				show_feedback("Plant watered 💧")
				tool_used = true
				call_deferred("setup_interaction_tools")
			else:
				show_feedback("Cannot water this plant")
		else:
			if not growth_component.is_planted:
				show_feedback("Plant needs to be planted first 🌱")
			elif growth_component.is_fully_grown:
				show_feedback("Plant is already fully grown 🌸")

	if not tool_used:
		damage_component.apply_dmg(hit_dmg)

func on_growth_changed(current_progress: float, max_progress: float):
	if progress_bar:
		progress_bar.value = current_progress
	update_progress_bar_color(current_progress / max_progress)

func update_progress_bar_color(progress_ratio: float):
	if not progress_bar:
		return
	var color = Color.RED.lerp(Color.GREEN, progress_ratio)
	if progress_bar.has_method("add_theme_color_override"):
		progress_bar.add_theme_color_override("fill", color)

func on_plant_fully_grown():
	show_feedback("Plant fully grown 🌸🎉")
	progress_bar.visible = false
	create_growth_effect()

func create_growth_effect():
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.2, 1.2), 0.2)
	tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.2)

func show_feedback(message: String):
	var feedback_label = Label.new()
	feedback_label.text = message
	feedback_label.position = Vector2(0, -50)
	feedback_label.add_theme_color_override("font_color", Color.WHITE)
	add_child(feedback_label)
	var tween = create_tween()
	tween.parallel().tween_property(feedback_label, "position", Vector2(0, -100), 1.0)
	tween.parallel().tween_property(feedback_label, "modulate:a", 0.0, 1.0)
	tween.tween_callback(feedback_label.queue_free)

func on_max_dmg_reached() -> void:
	if growth_component:
		growth_component.current_growth = 0.0
		growth_component.is_planted = false
		growth_component.is_fully_grown = false
	queue_free()
