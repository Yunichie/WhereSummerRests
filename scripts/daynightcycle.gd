extends CanvasModulate

@export var gradient: GradientTexture1D
@export var INGAME_SPEED = 1.0
@export var INIT_HOUR = 12:
	set(h):
		INIT_HOUR = h
		time = INGAME_TO_REAL * INIT_HOUR * MPH
var time: float = 0.0
var past_min: float = -1.0

const MPD = 1440
const MPH = 60
const INGAME_TO_REAL = (2 * PI) / MPD

signal time_tick(day: int, hour: int, min: int)

func _ready() -> void:
	time = INGAME_TO_REAL * INIT_HOUR * MPH

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.time += delta * INGAME_SPEED * INGAME_TO_REAL
	var value = (sin(time - PI / 2) + 1.0) / 2.0
	self.color = gradient.gradient.sample(value)
	_recalculate_time()
	
func _recalculate_time() -> void:
	var total_min = int(time / INGAME_TO_REAL)
	var day = int(total_min / MPD)
	var curr_day_min = total_min % MPD
	var hour = int(curr_day_min / MPH)
	var minute = int(curr_day_min % MPH)
	
	if past_min != minute:
		past_min = minute
		time_tick.emit(day, hour, min)
