class_name BeatSpawner
extends Node2D

export var direction: Vector2 = Vector2(1,0)
export var icon: Texture
export var target_path: NodePath
export (int, 1, 16) var delay_beats: int = 1
onready var target = get_node(target_path)

var map = (
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

var index: int = 0

func play():
	index = 0

func on_beat():
	if map[index % map.length()] != " ":
		spawn_beat()
	index = index+1 % map.length()

func spawn_beat():
	var beat = preload("res://beatmap/Beat.tscn").instance()
	add_child(beat)
	beat.speed =( target.global_position - global_position )/ get_parent().delay
	beat.set_texture(icon)
