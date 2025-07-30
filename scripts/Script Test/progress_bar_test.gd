extends ProgressBar
class_name PlantProgressBar

@export var display_percentage: bool = true
@export var background_color: Color = Color(0.2, 0.2, 0.2, 0.8)
@export var border_color: Color = Color.WHITE

var percentage_label: Label

func _ready():
	
	add_theme_color_override("background", background_color)

func _process(_delta):
	if percentage_label and max_value > 0:
		var percentage = int((value / max_value) * 100)
		percentage_label.text = str(percentage) + "%"
