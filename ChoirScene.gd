extends Control

func _on_Timer_timeout():
	for child in get_children():
		if child.get_child_count() > 0:
			var character = child.get_child(0)
			if character and character.has_method("on_beat"):
				character.on_beat()
				character.get_node("AnimationPlayer").playback_speed = 2


func _on_Skip_pressed():
	get_parent().show_credits()
