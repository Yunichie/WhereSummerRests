extends CharacterBody2D

@export var speed: float = 300.0
@export var friction: float = 0.9
@export var acceleration: float = 0.1

@onready var anim = $AnimatedSprite2D

func _ready():
	# Optional: Set up any initial configurations
	pass

func _physics_process(delta):
	handle_input_simple()
	move_and_slide()

func handle_input():
	# Get input vector from WASD or arrow keys
	var input_vector = Vector2.ZERO
	
	# Check for movement input
	if Input.is_action_pressed("move_up"):
		anim.play("walk_front")
		input_vector.y -= 1
	if Input.is_action_pressed("move_down"):
		anim.play("walk_back")
		input_vector.y += 1
	if Input.is_action_pressed("move_left"):
		anim.flip_h = true
		anim.play("walk_right")
		input_vector.x -= 1
	if Input.is_action_pressed("move_right"):
		anim.flip_h = false
		anim.play("walk_right")
		input_vector.x += 1
	
	# Normalize diagonal movement so it's not faster
	if input_vector != Vector2.ZERO:
		input_vector = input_vector.normalized()
		velocity = velocity.lerp(input_vector * speed, acceleration)
	else:
		# Apply friction when no input
		velocity = velocity.lerp(Vector2.ZERO, friction)
		anim.stop()

# Alternative simpler version (instant movement)
func handle_input_simple():
	var input_vector = Vector2.ZERO
	
	if Input.is_action_pressed("move_up"):
		anim.play("walk_front")
		input_vector.y -= 1
	if Input.is_action_pressed("move_down"):
		anim.play("walk_back")
		input_vector.y += 1
	if Input.is_action_pressed("move_left"):
		anim.flip_h = true
		anim.play("walk_right")
		input_vector.x -= 1
	if Input.is_action_pressed("move_right"):
		anim.flip_h = false
		anim.play("walk_right")
		input_vector.x += 1
	
	# Normalize and apply speed
	if input_vector != Vector2.ZERO:
		input_vector = input_vector.normalized()
		velocity = input_vector * speed
	else:
		velocity = Vector2.ZERO
		anim.play("idle_front")
