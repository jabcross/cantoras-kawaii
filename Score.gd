extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var value : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	text = String(value)

func _on_Middle_point(val):
	value += val
	if value < 0: value = 0
	text = String(value)
