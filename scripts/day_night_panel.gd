extends Control

@onready var day_label: Label = $DayPanel/MarginContainer/DayLabel
@onready var time_label: Label = $TimePanel/MarginContainer/TimeLabel

func _ready() -> void:
	DayNightManager.time_tick.connect(on_time_tick)
	
func on_time_tick(day: int, hour: int, min: int) -> void:
	day_label.text = "Day " + str(day)
	time_label.text = "%02d:%02d" % [hour, min]
