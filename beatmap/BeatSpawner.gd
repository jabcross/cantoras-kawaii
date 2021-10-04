class_name BeatSpawner
extends Node2D

export var direction: Vector2 = Vector2(1,0)
export var icon: Texture
export (int, 1, 16) var delay_beats: int = 1
export var target_path: NodePath
onready var target = get_node(target_path)
export var beatmap : String
export var multiplier: int = 1
var offbeat = 0;
var map: String = "."

export var character_path: NodePath
var character

func reset():
	index = 0;
	for child in get_children():
		child.queue_free()

func _ready():
	character = get_node(character_path)
	if beatmap:
		var file = File.new()
		file.open(beatmap,File.READ)
		map = file.get_as_text().replace("\n","")
		file.close()
		
var index: int = 0

func on_beat(beat_length: float):
	print("on_beat")
	match map[index % map.length()]:
		"-":
			spawn_beat(index * beat_length)
	index = index+1 % map.length()

func spawn_beat(target_transport: float):
	var beat = preload("res://beatmap/Beat.tscn").instance()
	beat.middle_pos = $'../Middle'.global_position
	beat.spawn_beat = get_parent().transport
	beat.target_beat = beat.spawn_beat + get_parent().delay
	beat.character = character
	add_child(beat)
	beat.set_texture(icon)
