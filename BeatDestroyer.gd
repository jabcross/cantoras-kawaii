extends Node2D

export var direction: Vector2 = Vector2.RIGHT

func _ready():
	pass # Replace with function body.


func _on_Area2D_body_shape_entered(body_id, body, body_shape, local_shape):
	var beat : Beat = body.get_parent() as Beat
	if beat and !beat.has_hit:
		if beat.progress > 1.0:
			beat.fail()
