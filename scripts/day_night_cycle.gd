class_name DayNightCycle
extends CanvasModulate

@export var init_day: int = 1:
	set(id):
		init_day = id
		DayNightManager.initial_day = id
		DayNightManager.set_init_time()
		
@export var init_hour: int = 12:
	set(ih):
		init_hour = ih
		DayNightManager.initial_hour = ih
		DayNightManager.set_initial_time()
		
@export var init_min: int = 30:
	set(im):
		init_min = im
		DayNightManager.initial_minute = im
		DayNightManager.set_initial_time()
		
@export var day_night_grad_texture: GradientTexture1D

func _ready() -> void:
	DayNightManager.initial_day = init_day
	DayNightManager.initial_hour = init_hour
	DayNightManager.initial_minute = init_min
	DayNightManager.set_initial_time()
	
	DayNightManager.game_time.connect(on_game_time)

func on_game_time(time: float) -> void:
	var sample_val = 0.5 * (sin(time - PI * 0.5) + 1.0)
	color = day_night_grad_texture.gradient.sample(sample_val)
