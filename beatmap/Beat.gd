class_name Beat
extends Node2D

var speed: Vector2
var character
var is_beginning_of_sustain: bool = false
var is_ending_of_sustain: bool = false

var has_hit = false

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

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
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += delta * speed

func fail():
	$Icon.hide()
	character.error()
	$FailParticle.emitting = true
	yield(get_tree().create_timer(5.0),"timeout")
	queue_free()
	
func hit():
	$Icon.hide()
	character.sing()
	has_hit = true
	$HitParticle.emitting = true
	yield(get_tree().create_timer(5.0),"timeout")
	queue_free()
