extends NodeState

@export var player: Player
@export var anim: AnimatedSprite2D

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
	elif player.player_direction == Vector2.DOWN:
		anim.play("dummy_anim")
	elif player.player_direction == Vector2.RIGHT:
		anim.flip_h = false 
		anim.play("dummy_anim")
	elif player.player_direction == Vector2.LEFT:
		anim.flip_h = true
		anim.play("dummy_anim")
	else:
		anim.play("dummy_anim")


func _on_exit() -> void:
	anim.stop()
