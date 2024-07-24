extends CanvasModulate

const NIGHT_COLOR = Color("#091d3a")
const DAY_COLOR = Color("#dfdfdf")
const EVENING_COLOR = Color("#ff3300")

const TIME_SCALE = 0.1

var time = 0
var game_end = false

func _process(delta:float) -> void:
	self.time += delta * TIME_SCALE
	var value = (sin(time) + 1)/2
	#self.color = get_source_colour(value).lerp(get_target_colour(value), value)
	self.color = EVENING_COLOR
	
func get_source_colour(value):
	return NIGHT_COLOR.lerp(EVENING_COLOR, value)

func get_target_colour(value):
	return EVENING_COLOR.lerp(DAY_COLOR, value)
	
