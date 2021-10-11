extends Control

func _ready():
	pass

func reset_screen():
	get_node("PodiumLeft/Baleia").hide()
	get_node("PodiumLeft/Leoa").hide()
	get_node("PodiumLeft/Morcegue").hide()
	get_node("PodiumLeft/Sapa").hide()
	$TotalBeats.hide()
	$BeatsHit.hide()
	$BeatsMissed.hide()
	$FinalScore.hide()
	$Grade.hide()
	$Percentage.hide()
	
	get_node("PodiumLeft/Baleia/Sustain").show()
	get_node("PodiumLeft/Leoa/Sustain").show()
	get_node("PodiumLeft/Morcegue/Sustain").show()
	get_node("PodiumLeft/Sapa/Sustain").show()
	
	get_node("PodiumLeft/Baleia/Error").hide()
	get_node("PodiumLeft/Leoa/Error").hide()
	get_node("PodiumLeft/Morcegue/Error").hide()
	get_node("PodiumLeft/Sapa/Error").hide()

func update_scores(score, total_beats, beats_hit, character):
	
	$TotalBeats.text = String(total_beats)
	$BeatsHit.text = String(beats_hit)
	$BeatsMissed.text = String(total_beats - beats_hit)
	$FinalScore.text = String(score)
	
	var ideal_score = total_beats * 100
	
	var percentage = 0
	
	if ideal_score != 0: percentage = stepify(float(score) / float(ideal_score), 0.01)
	
	$Percentage.text = String(percentage * 100) + "%"
	
	if percentage >= 0.9: $Grade.text = "S"
	elif percentage >= 0.8: $Grade.text = "A"
	elif percentage >= 0.7: $Grade.text = "B"
	elif percentage >= 0.6: $Grade.text = "C"
	elif percentage >= 0.5: $Grade.text = "D"
	else:
		$Grade.text = "F"
		get_node("PodiumLeft/Baleia/Sustain").hide()
		get_node("PodiumLeft/Leoa/Sustain").hide()
		get_node("PodiumLeft/Morcegue/Sustain").hide()
		get_node("PodiumLeft/Sapa/Sustain").hide()
		
		get_node("PodiumLeft/Baleia/Error").show()
		get_node("PodiumLeft/Leoa/Error").show()
		get_node("PodiumLeft/Morcegue/Error").show()
		get_node("PodiumLeft/Sapa/Error").show()
	
	if character == "Baleia": get_node("PodiumLeft/Baleia").show()
	elif character == "Leoa": get_node("PodiumLeft/Leoa").show()
	elif character == "Morcegue": get_node("PodiumLeft/Morcegue").show()
	elif character == "Sapa": get_node("PodiumLeft/Sapa").show()
	
	dramatic_reveal()
	
func dramatic_reveal():
	yield(get_tree().create_timer(1), "timeout")
	$TotalBeats.show()
	yield(get_tree().create_timer(1), "timeout")
	$BeatsHit.show()
	yield(get_tree().create_timer(1), "timeout")
	$BeatsMissed.show()
	yield(get_tree().create_timer(1), "timeout")
	$FinalScore.show()
	yield(get_tree().create_timer(1), "timeout")
	$Grade.show()
	$Percentage.show()

func _on_Button_pressed():
	get_parent().return_to_title(self)
