extends NodeState

@export var player: Player
@export var anim: AnimatedSprite2D
@export var pre_interaction_component_collision_shape: CollisionShape2D

func _ready() -> void:
	pre_interaction_component_collision_shape.disabled = true
	pre_interaction_component_collision_shape.position = Vector2(0, 0)

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	pass


func _on_next_transitions() -> void:
	if !anim.is_playing():
		transition.emit("Idle")


func _on_enter() -> void:
	if player.player_direction == Vector2.UP:
		anim.play("dummy_anim")
		pre_interaction_component_collision_shape.position = Vector2(1, -20)
	elif player.player_direction == Vector2.DOWN:
		anim.play("dummy_anim")
		pre_interaction_component_collision_shape.position = Vector2(1, 20)
	elif player.player_direction == Vector2.RIGHT:
		anim.flip_h = false 
		anim.play("dummy_anim")
		pre_interaction_component_collision_shape.position = Vector2(10, 8)
	elif player.player_direction == Vector2.LEFT:
		anim.flip_h = true
		anim.play("dummy_anim")
		pre_interaction_component_collision_shape.position = Vector2(-10, 8)
	else:
		anim.play("dummy_anim")
		pre_interaction_component_collision_shape.position = Vector2(1, 20)

	pre_interaction_component_collision_shape.disabled = false

func _on_exit() -> void:
	anim.stop()
	pre_interaction_component_collision_shape.disabled = true
