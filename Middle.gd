extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	position = $"../BeatSpawnerLeft".position + $"../BeatSpawnerRight".position
	position /= 2.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if not get_parent().song_has_started:
		return
	if Input.is_action_just_pressed("left_button"):
		var found_left_note = false
		for body in $Area.get_overlapping_bodies():
			var beat: Beat = body.get_parent() as Beat
			if beat:
				if beat.speed.x > 0:
					if not beat.is_ending_of_sustain:
						beat.hit()
						found_left_note = true
		if not found_left_note:
			$"../PodiumLeft/Character".error()
			
	if Input.is_action_just_pressed("right_button"):
		var found_right_note = false
		for body in $Area.get_overlapping_bodies():
			var beat: Beat = body.get_parent() as Beat
			if beat:
				if beat.speed.x < 0:
					if not beat.is_ending_of_sustain:
						beat.hit()
						found_right_note = true
		if not found_right_note:
			$"../PodiumRight/Character".error()
