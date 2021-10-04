extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal point(val)

# Called when the node enters the scene tree for the first time.
func _ready():
	position = $"../BeatSpawnerLeft".position + $"../BeatSpawnerRight".position
	position /= 2.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if not get_parent().song_has_started:
		return
	for pair in  [["left_button",$"../PodiumLeft/Character"],
				["right_button",$"../PodiumRight/Character"]]:
		var button = pair[0]
		var character = pair[1]
		if Input.is_action_just_pressed(button):
			var found_note = false
			for body in $Area.get_overlapping_bodies():
				var beat: Beat = body.get_parent() as Beat
				if beat and beat.is_alive():
					if beat.character == character:
						if not beat.is_ending_of_sustain:
							beat.hit()
							add_point()
							found_note = true
							break;
			if not found_note:
				character.error()
				deduct_point();

func add_point():
	emit_signal("point", 1)

func deduct_point():
	emit_signal("point", -1)
