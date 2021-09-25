extends Control

export var bpm : float = 100.0
export var delay : float = 5.5
export(float, 0, 1.0) var offset = 0.0
onready var beat_length = 1.0 / bpm * 60 * 1000.0 / 4.0
onready var index = 0
var start_msec
var ms_since_song_started
var playing = false
var last_beat = 0

func _ready():
	pass 
	
func play():
	playing = true
	$DancingGodot/AnimationPlayer.play("dance")
	$DancingGodot/AnimationPlayer.playback_speed = bpm / 60.0 / 4.0
	for i in [$PodiumLeft/CharacterLeft/AnimationPlayer,
			$PodiumRight/CharacterRight/AnimationPlayer]:
		i.play("dance")
		i.playback_speed = bpm / 60.0
	start_msec = OS.get_ticks_msec()
	ms_since_song_started = 0.0
	playing = true
	yield(get_tree().create_timer(delay),"timeout")
	$AudioStreamPlayer.play()

func stop():
	playing = false
	$AudioStreamPlayer.stop()
	$DancingGodot/AnimationPlayer.play("stop")
	$PodiumLeft/CharacterLeft/AnimationPlayer.play("idle")
	$PodiumRight/CharacterRight/AnimationPlayer.play("idle")

func _process(delta):
	if playing:
		ms_since_song_started = OS.get_ticks_msec() - start_msec
		var beat = int(floor(ms_since_song_started / beat_length + offset))
		if beat != last_beat:
			for spawner in [$BeatSpawnerLeft, $BeatSpawnerRight]:
				spawner.on_beat()
		last_beat = beat

func _on_PlayButton_pressed():
	play()

func _on_StopButton_pressed():
	stop()
	
