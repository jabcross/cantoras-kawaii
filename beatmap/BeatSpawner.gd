class_name BeatSpawner
extends Node2D

export onready var song = load("res://songs/test/mandrill.mp3")
export var bpm : float = 100.0
export var delay : float = 1.0
var map = (
"    x x x x x x " +
"-               " +
"- x x x x x x x " +
"  x x       x xx" +
"-           xxxx" +
"-               " +
"- x x x x x x x " +
"  x x   x x x x " +
"-               " +
"-               " +
"-               " +
"-               " +
"-               " +
"-               " +
"-               " +
"-               " +
"-               " +
"-               " +
"-               " +
"-               " +
"-               " +
"-               " +
"-               " +
"-               " +
"-               " +
""
)
export(float, 0, 1.0) var offset = 0.0

onready var index = 0
var start_msec
var ms_since_song_started
onready var beat_length = 1.0 / bpm * 60 * 1000.0 / 4.0
var p 
var playing = false
var last_beat = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer.stream = song

func play():
	start_msec = OS.get_ticks_msec()
	ms_since_song_started = 0.0
	playing = true
	yield(get_tree().create_timer(delay),"timeout")
	$AudioStreamPlayer.play()

func stop():
	$AudioStreamPlayer.stop()
	playing = false

func _process(delta):
	if playing:
		ms_since_song_started = OS.get_ticks_msec() - start_msec
		var beat = int(floor(ms_since_song_started / beat_length + offset))
		if beat != last_beat:
			on_beat()
		last_beat = beat

func on_beat():
	if map[index%map.length()] != " ":
		spawn_beat()
	index = index+1 % map.length()

func spawn_beat():
	var beat = preload("res://beatmap/Beat.tscn").instance()
	add_child(beat)



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
