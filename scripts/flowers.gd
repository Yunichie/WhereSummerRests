extends Sprite2D

@onready var post_interaction: PostInterComponent = $PostInteraction
@onready var damage_component: DamageComponent = $DamageComponent

func _ready() -> void:
	post_interaction.interact.connect(on_interact)
	damage_component.max_dmg_reached.connect(on_max_dmg_reached)
	
func on_interact(hit_dmg: int) -> void:
	damage_component.apply_dmg(hit_dmg)
	material.set_shader_parameter("shake_intensity", 0.5)
	await get_tree().create_timer(1.0).timeout
	material.set_shader_parameter("shake_intensity", 0.0)
	
func on_max_dmg_reached() -> void:
	queue_free()
