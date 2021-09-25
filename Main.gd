extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var play_button : Button = $PlayButton
onready var stop_button : Button = $StopButton

# Called when the node enters the scene tree for the first time.
func _ready():
	play_button.connect("pressed", self, "on_play_button")
	stop_button.connect("pressed", self, "on_stop_button")

func on_play_button():
	$Character/AnimationPlayer.play("dance")
	$Character/AnimationPlayer.playback_speed = $BeatSpawner.bpm / 60.0 / 2.0
	$BeatSpawner.play()
	
func on_stop_button():
	$BeatSpawner.stop()	
	$Character/AnimationPlayer.play("stop")
