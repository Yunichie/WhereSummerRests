extends NodeState

@export var player: Player
@export var anim: AnimatedSprite2D
@export var speed: int = 100

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	var direction: Vector2 = GameInputEvents.movement_input()
	
	if direction == Vector2.UP:
		anim.play("walk_front")
	elif direction == Vector2.DOWN:
		anim.play("walk_back")
	elif direction == Vector2.RIGHT:
		anim.flip_h = false 
		anim.play("walk_right")
	elif direction == Vector2.LEFT:
		anim.flip_h = true
		anim.play("walk_right")
		
	if direction != Vector2.ZERO:
		player.player_direction = direction
	
	player.velocity = direction * speed
	player.move_and_slide()

func _on_next_transitions() -> void:
	#GameInputEvents.movement_input()
	
	if !GameInputEvents.is_movement_input():
		transition.emit("Idle")


func _on_enter() -> void:
	pass


func _on_exit() -> void:
	anim.stop()
