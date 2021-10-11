extends Label

var points : int = 0
var total_beats : int = 0
var beats_hit : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	text = String(points)

func add_beat():
	total_beats += 1

func _on_Middle_point(val):
	if val == 100: beats_hit += 1
	
	points += val
	if points < 0: points = 0
	text = String(points)

func reset():
	points = 0
	total_beats = 0
	beats_hit = 0
	text = "0"
