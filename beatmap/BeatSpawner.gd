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

func _ready():
	character = get_node(character_path)
	if beatmap:
		var file = File.new()
		file.open(beatmap,File.READ)
		map = file.get_as_text().replace("\n","")
		file.close()
		
var index: int = 0

func play():
	index = 0

func on_beat():
	match map[index % map.length()]:
		"-":
			spawn_beat()
	index = index+1 % map.length()

func spawn_beat():
	var beat = preload("res://beatmap/Beat.tscn").instance()
	add_child(beat)
	beat.speed =( target.global_position - global_position )/ get_parent().delay
	beat.character = character
	beat.set_texture(icon)
