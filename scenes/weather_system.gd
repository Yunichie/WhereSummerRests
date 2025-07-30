extends Node

@export var rain_weather_scene: PackedScene
@export var windy_weather_scene: PackedScene

@export var min_wait_time: float = 30.0
@export var max_wait_time: float = 120.0
@export var min_weather_duration: float = 20.0
@export var max_weather_duration: float = 60.0

var spawn_timer: Timer
var duration_timer: Timer

var current_weather_instance: Node

var weather_scenes: Array = []

func _ready():
	# Setup available weather scenes
	if rain_weather_scene:
		weather_scenes.append(rain_weather_scene)
	if windy_weather_scene:
		weather_scenes.append(windy_weather_scene)
	
	if weather_scenes.is_empty():
		print("Warning: No weather scenes assigned!")
		return
	
	spawn_timer = Timer.new()
	duration_timer = Timer.new()
	add_child(spawn_timer)
	add_child(duration_timer)
	
	spawn_timer.connect("timeout", _spawn_random_weather)
	duration_timer.connect("timeout", _end_weather)
	
	_schedule_next_weather()

func _schedule_next_weather():
	var wait_time = randf_range(min_wait_time, max_wait_time)
	spawn_timer.wait_time = wait_time
	spawn_timer.one_shot = true
	spawn_timer.start()
	
	print("Next weather in: ", snappedf(wait_time, 0.1), " seconds")

func _spawn_random_weather():
	if weather_scenes.is_empty():
		return
	
	_clear_current_weather()
	
	var random_scene = weather_scenes[randi() % weather_scenes.size()]
	current_weather_instance = random_scene.instantiate()
	
	get_tree().current_scene.add_child(current_weather_instance)
	
	var duration = randf_range(min_weather_duration, max_weather_duration)
	duration_timer.wait_time = duration
	duration_timer.one_shot = true
	duration_timer.start()
	
	print("Weather started: ", current_weather_instance.name, " for ", snappedf(duration, 0.1), " seconds")

func _end_weather():
	_clear_current_weather()
	_schedule_next_weather()
	print("Weather ended")

func _clear_current_weather():
	if current_weather_instance:
		current_weather_instance.queue_free()
		current_weather_instance = null

func spawn_rain():
	if rain_weather_scene:
		_clear_current_weather()
		current_weather_instance = rain_weather_scene.instantiate()
		get_tree().current_scene.add_child(current_weather_instance)

func spawn_windy():
	if windy_weather_scene:
		_clear_current_weather()
		current_weather_instance = windy_weather_scene.instantiate()
		get_tree().current_scene.add_child(current_weather_instance)

func clear_weather():
	_clear_current_weather()

func is_weather_active() -> bool:
	return current_weather_instance != null
