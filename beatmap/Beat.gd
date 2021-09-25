class_name Beat
extends Node2D

var speed: Vector2

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func set_texture(tex: Texture):
	$Icon.texture = tex
	$Particles2D.process_material = $Particles2D.process_material.duplicate()
	$Particles2D.process_material.scale = $Icon.rect_size.x / tex.get_size().x
	$Particles2D.texture = tex

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += delta * speed

func fail():
	$Icon.hide()
	$Particles2D.emitting = true
	yield(get_tree().create_timer(5.0),"timeout")
	queue_free()
