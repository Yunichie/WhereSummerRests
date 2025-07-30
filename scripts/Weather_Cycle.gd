extends CanvasModulate

@export var weather_color: Color = Color(1, 1, 1)  # Default: Clear

func _ready():
	self.color = weather_color
