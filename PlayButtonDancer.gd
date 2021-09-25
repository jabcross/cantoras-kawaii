extends Button

export var target_path : NodePath 
onready var target : CanvasItem = get_node(target_path)

func _process(delta):
	rect_scale = target.get_transform().get_scale()
	rect_rotation = target.get_transform().get_rotation()/2.0/PI*360.0
