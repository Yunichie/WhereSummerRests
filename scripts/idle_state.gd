extends NodeState

@export var player: Player
@export var anim: AnimatedSprite2D

var direction: Vector2

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	if player.player_direction == Vector2.UP:
		anim.play("idle_back")
	elif player.player_direction == Vector2.DOWN:
		anim.play("idle_front")
	elif player.player_direction == Vector2.RIGHT:
		anim.flip_h = false 
		anim.play("idle_right")
	elif player.player_direction == Vector2.LEFT:
		anim.flip_h = true
		anim.play("idle_right")


func _on_next_transitions() -> void:
	GameInputEvents.movement_input()
	
	if GameInputEvents.is_movement_input():
		transition.emit("Walk")
		
	if player.current_tool == DataTypes.Tools.WaterFlowers && GameInputEvents.use_tool():
		transition.emit("Watering")
	
	if player.current_tool == DataTypes.Tools.PlantFlowers && GameInputEvents.use_tool():
		transition.emit("Planting")
		
	if player.current_tool == DataTypes.Tools.FertilizeFlowers && GameInputEvents.use_tool():
		transition.emit("Fertilizing")

func _on_enter() -> void:
	pass


func _on_exit() -> void:
	anim.stop()
