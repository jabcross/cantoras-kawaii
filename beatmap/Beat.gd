class_name Beat
extends Node2D

var middle_pos: Vector2
var spawn_pos: Vector2
var target_beat: float = 0.0
var spawn_beat: float = 0.0
var progress = 0.0
var character
var is_beginning_of_sustain: bool = false
var is_ending_of_sustain: bool = false

var has_hit = false

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func is_alive():
	return not has_hit and not is_queued_for_deletion()

func set_texture(tex: Texture):
	$Icon.texture = tex
	$FailParticle.process_material = $FailParticle.process_material.duplicate()
	$FailParticle.process_material.scale = $Icon.rect_size.x / tex.get_size().x
	$FailParticle.texture = tex
	$HitParticle.process_material = $HitParticle.process_material.duplicate()
	$HitParticle.process_material.scale = $Icon.rect_size.x / tex.get_size().x
	$HitParticle.texture = tex

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_pos = global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# set position
	var full_progress_time = target_beat - spawn_beat
	var current_progress_time = get_parent().get_parent().transport - spawn_beat
	progress = current_progress_time / full_progress_time
	global_position = (middle_pos - spawn_pos) * progress + spawn_pos

func fail():
	if has_hit == false:
		character.error()
		$FailParticle.emitting = true
		yield(get_tree(),"idle_frame")
		$Icon.hide()
		yield(get_tree().create_timer(5.0),"timeout")
		queue_free()
	
func hit():
	has_hit = true
	character.sing()
	$HitParticle.emitting = true
	yield(get_tree(),"idle_frame")
	$Icon.hide()	
	yield(get_tree().create_timer(5.0),"timeout")
	queue_free()
