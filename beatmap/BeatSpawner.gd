extends Node2D

export var song: Script
export(float, 0, 1.0) var offset = 0.0

onready var instance = song.new()
onready var index = 0
var start_msec
var ms_since_song_started
var beat_length
var p 
var playing = false
var last_beat = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	beat_length = 1.0 / instance.bpm * 60 * 1000.0 / 4.0

func play():
	start_msec = OS.get_ticks_msec()
	ms_since_song_started = 0.0
	playing = true

func _process(delta):
	if playing:
		ms_since_song_started = OS.get_ticks_msec() - start_msec
		var beat = int(floor(ms_since_song_started / beat_length + offset))
		if beat != last_beat:
			on_beat()
		last_beat = beat

func on_beat():
	if instance.map[index%instance.map.length()] != " ":
		spawn_beat()
	index = index+1 % instance.map.length()

func spawn_beat():
	var beat = preload("res://beatmap/Beat.tscn").instance()
	add_child(beat)



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
