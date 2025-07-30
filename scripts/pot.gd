extends Sprite2D

@onready var post_interaction: PostInterComponent = $PostInteraction
@onready var damage_component: DamageComponent = $DamageComponent
@export var Type: String

func _ready() -> void:
	post_interaction.interact.connect(on_interact)
	damage_component.max_dmg_reached.connect(on_max_dmg_reached)
	add_to_group("pots")
	
	
func on_interact(hit_dmg: int) -> void:
	damage_component.apply_dmg(hit_dmg)
	
func on_max_dmg_reached() -> void:
	queue_free()
