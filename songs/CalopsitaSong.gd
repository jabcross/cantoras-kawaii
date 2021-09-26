extends AudioStreamPlayer


func _on_Battle_song_started():
	seek(0)
	play()
