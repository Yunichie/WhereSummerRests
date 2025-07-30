class_name Player
extends CharacterBody2D

@export var current_tool: DataTypes.Tools = DataTypes.Tools.None
@onready var pre_interaction: PreInteraction = $PreInteraction
@onready var interaction_area: Area2D = $InteractionArea

var player_direction: Vector2
var can_interact_with_pot: bool = false
var current_pot: Node2D = null
var pot_scene_path: String = "res://scenes/objects/pot.tscn" # Sesuaikan dengan path scene Pot Anda

func _ready() -> void:
	ToolManager.tool_selected.connect(on_tool_selected)
	
	# Setup collision layers dan masks
	# Player collision layer = 2
	collision_layer = 2
	
	# Setup interaction area untuk player
	if interaction_area:
		interaction_area.body_entered.connect(_on_interaction_area_body_entered)
		interaction_area.body_exited.connect(_on_interaction_area_body_exited)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and can_interact_with_pot and current_pot:
		show_pot_scene()

func on_tool_selected(tool: DataTypes.Tools) -> void:
	current_tool = tool
	pre_interaction.current_tool = tool

func _on_interaction_area_body_entered(body: Node2D) -> void:
	# Cek apakah body adalah Pot menggunakan has_method atau group
	if body.has_method("get_pot_type") or body.is_in_group("pots"):
		can_interact_with_pot = true
		current_pot = body
		show_interaction_prompt()

func _on_interaction_area_body_exited(body: Node2D) -> void:
	if body.has_method("get_pot_type") or body.is_in_group("pots"):
		can_interact_with_pot = false
		current_pot = null
		hide_interaction_prompt()

func show_pot_scene() -> void:
	# Metode 1: Ganti scene langsung
	get_tree().change_scene_to_file(pot_scene_path)
	
	# Metode 2: Load scene sebagai overlay (uncomment jika ingin menggunakan)
	# var pot_scene = load(pot_scene_path)
	# var pot_instance = pot_scene.instantiate()
	# get_tree().current_scene.add_child(pot_instance)

func show_interaction_prompt() -> void:
	# Implementasi untuk menampilkan prompt "Press E to interact"
	# Bisa menggunakan UI Label atau sistem notifikasi Anda
	print("Press E to interact with pot")

func hide_interaction_prompt() -> void:
	# Implementasi untuk menyembunyikan prompt
	print("Interaction prompt hidden")
