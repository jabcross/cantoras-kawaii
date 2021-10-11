class_name Battle
extends Control

signal song_started

export var bpm : float = 110.0
export var delay : float = 5.5
export(float, 0, 1.0) var offset = 0.0
onready var beat_length = 1.0 / bpm * 60.0 / 4.0
onready var index = 0
var transport = 0.0
var us_since_level_started = 0.0
var level_has_started = false
export var multiplier: int = 1
var offbeat = 0
var last_beat = 9999999
var song_has_started :bool = false

var start_timer : SceneTreeTimer

onready var spawnerleft = $BeatSpawnerLeft
onready var spawnerright = $BeatSpawnerRight
onready var calopsitasong = $CalopsitaSong
onready var othersong = $AudioStreamPlayer
onready var leftcharacter = $PodiumLeft.get_child(0)
onready var rightcharacter = $PodiumRight.get_child(0)
onready var leftanimation = leftcharacter.get_node("AnimationPlayer")
onready var rightanimation = rightcharacter.get_node("AnimationPlayer")

func _ready():
#	calopsitasong.play()
#	othersong.play()
#	yield(get_tree(),"idle_frame")
#	yield(get_tree(),"idle_frame")
#	yield(get_tree(),"idle_frame")
#	calopsitasong.stop()
#	othersong.stop()
#	yield(get_tree(),"idle_frame")
#	yield(get_tree(),"idle_frame")
#	yield(get_tree(),"idle_frame")
#	calopsitasong.stop()
#	othersong.stop()
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"),false)

	
func play():
	spawnerleft.reset()
	spawnerright.reset()
#	othersong.stop()
#	calopsitasong.stop()	
	level_has_started = true
	song_has_started = false
	for i in [leftanimation,rightanimation]:
		i.play("dance")
		i.playback_speed = bpm / 60.0
	transport = -delay
	us_since_level_started = OS.get_ticks_usec()

	yield(get_tree().create_timer(43), "timeout")
	finish()

func finish():
	level_has_started = false
	othersong.stop()
	calopsitasong.stop()
	leftanimation.play("idle")
	rightanimation.play("idle")
	get_parent().show_score(self)

func stop():
	level_has_started = false
	othersong.stop()
	calopsitasong.stop()
	leftanimation.play("idle")
	rightanimation.play("idle")	
	get_parent().return_to_title(self)

func _process(delta):
	if not visible:
		return

	transport = float(OS.get_ticks_usec() - us_since_level_started)/1e6 - delay
	if visible and not song_has_started and transport >= 0.0:
		song_has_started = true
		othersong.play(transport)
		calopsitasong.play(transport)

	if level_has_started:
		var beat = int(floor(((transport + delay) / beat_length + offset)))
		if beat != last_beat:
			if offbeat == 0:
				for spawner in [spawnerleft,spawnerright]:
					print(beat)
					spawner.on_beat(beat_length)
				for c in [leftcharacter, rightcharacter]:
					var character : Character = c as Character 
					if character.is_dancing:
						character.dance()

			offbeat = (offbeat + 1) % multiplier
		last_beat = beat

func _on_Button_pressed():
	$Label.points = 0
	$Label.total_beats = 0
	$Label.beats_hit = 0
	$Label.text = "0"
	
	stop()
