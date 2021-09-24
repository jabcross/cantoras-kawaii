extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var play_button : Button = $PlayButton
onready var stop_button : Button = $StopButton
onready var audio_player : AudioStreamPlayer = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	play_button.connect("pressed", self, "on_play_button")
	stop_button.connect("pressed", self, "on_stop_button")

func on_play_button():
	audio_player.play()
	
func on_stop_button():
	audio_player.stop()
