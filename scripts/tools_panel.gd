extends PanelContainer

@onready var tool_watering_can: Button = $MarginContainer/HBoxContainer/ToolWateringCan
@onready var tool_fertilize: Button = $MarginContainer/HBoxContainer/ToolFertilize
@onready var tool_scissor: Button = $MarginContainer/HBoxContainer/ToolScissor
@onready var tool_canopy: Button = $MarginContainer/HBoxContainer/ToolCanopy
@onready var Seeds: Button = $MarginContainer/HBoxContainer/Seeds

var current_selected_button: Button = null
var tool_buttons: Array[Button] = []

func _ready() -> void:
	# Tambahkan semua tool buttons ke array
	tool_buttons = [tool_watering_can, tool_fertilize, tool_scissor, tool_canopy, Seeds]
	
	# Connect semua button signals
	tool_watering_can.pressed.connect(_on_tool_watering_can_pressed)
	tool_fertilize.pressed.connect(_on_tool_fertilize_pressed)
	tool_scissor.pressed.connect(_on_tool_scissor_pressed) 
	tool_canopy.pressed.connect(_on_tool_canopy_pressed)
	Seeds.pressed.connect(_on_tool_seeds_pressed)
	
	# Set initial state - no tool selected
	update_button_states(null)

func _on_tool_watering_can_pressed() -> void:
	select_tool(tool_watering_can, DataTypes.Tools.WaterFlowers)

func _on_tool_fertilize_pressed() -> void:
	select_tool(tool_fertilize, DataTypes.Tools.FertilizeFlowers)

func _on_tool_scissor_pressed() -> void:
	select_tool(tool_scissor, DataTypes.Tools.DiseaseManagement)

func _on_tool_canopy_pressed() -> void:
	select_tool(tool_canopy, DataTypes.Tools.Canopy)

func _on_tool_seeds_pressed() -> void:
	select_tool(Seeds, DataTypes.Tools.PlantFlowers)

func select_tool(button: Button, tool_type: DataTypes.Tools) -> void:
	# Jika button yang sama diklik lagi, deselect tool
	if current_selected_button == button:
		ToolManager.select_tool(DataTypes.Tools.None)
		update_button_states(null)
	else:
		# Select tool baru
		ToolManager.select_tool(tool_type)
		update_button_states(button)

func update_button_states(selected_button: Button) -> void:
	current_selected_button = selected_button
	
	# Reset semua button states
	for btn in tool_buttons:
		if btn:
			btn.button_pressed = false
			# Reset modulate atau style jika ada
			btn.modulate = Color.WHITE
	
	# Highlight selected button
	if selected_button:
		selected_button.button_pressed = true
		# Berikan visual feedback (bisa disesuaikan dengan theme Anda)
		selected_button.modulate = Color(1.2, 1.2, 1.2)  # Slightly brighter

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("release_tool"):
		ToolManager.select_tool(DataTypes.Tools.None)
		update_button_states(null)
	
	# Keyboard shortcuts (opsional)
	elif event.is_action_pressed("tool_1"):
		_on_tool_watering_can_pressed()
	elif event.is_action_pressed("tool_2"):
		_on_tool_fertilize_pressed()
	elif event.is_action_pressed("tool_3"):
		_on_tool_scissor_pressed()
	elif event.is_action_pressed("tool_4"):
		_on_tool_canopy_pressed()
	elif event.is_action_pressed("tool_5"):
		_on_tool_seeds_pressed()
