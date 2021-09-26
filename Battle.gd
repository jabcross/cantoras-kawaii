extends Control

signal song_started

export var bpm : float = 100.0
export var delay : float = 5.5
export(float, 0, 1.0) var offset = 0.0
onready var beat_length = 1.0 / bpm * 60 * 1000000.0 / 4.0
onready var index = 0
var start_usec
var us_since_song_started
var playing = false
export var multiplier: int = 1
var offbeat = 0
var last_beat = 0
var song_has_started :bool = false

func _ready():
	pass 
	
func play():
	playing = true
	for i in [$PodiumLeft/Character/AnimationPlayer,
			$PodiumRight/Character/AnimationPlayer]:
		i.play("dance")
		i.playback_speed = bpm / 60.0
	start_usec = OS.get_ticks_usec()
	us_since_song_started = 0.0
	playing = true
	yield(get_tree().create_timer(delay),"timeout")
	emit_signal("song_started")
	song_has_started = true
	$AudioStreamPlayer.play()

func stop():
	playing = false
	$AudioStreamPlayer.stop()
	$DancingGodot/AnimationPlayer.play("stop")
	$PodiumLeft/Character/AnimationPlayer.play("idle")
	$PodiumRight/Character/AnimationPlayer.play("idle")

func _process(delta):
	if playing:
		us_since_song_started = OS.get_ticks_usec() - start_usec
		var beat = int(floor(us_since_song_started / beat_length + offset))
		if beat != last_beat:
			if offbeat == 0:
				for spawner in [$BeatSpawnerLeft, $BeatSpawnerRight]:
					spawner.on_beat()
				for c in [$PodiumLeft/Character, $PodiumRight/Character]:
					var character : Character = c as Character 
					if character.is_dancing:
						character.dance()

			offbeat = (offbeat + 1) % multiplier				
		last_beat = beat

func _on_PlayButton_pressed():
	play()

func _on_StopButton_pressed():
	stop()
	
