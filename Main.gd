extends Control

#func return_to_title(battle):
#	$Fade.show()
#	$Tween.interpolate_property($Fade,"modulate",Color.transparent,Color.white,1.0);
#	$Tween.start();
#	yield($Tween,"tween_completed")
#	battle.hide()
#	$TitleScreen.show()
#	$Tween.interpolate_property($Fade,"modulate",Color.white,Color.transparent,1.0);
#	$Tween.start();
#	yield($Tween,"tween_completed")
#	$Fade.hide()
#	battle.get_node("Label").reset()

func return_to_selection_screen(scene):
	if get_node("SelectionScreen/BatGrade").text == "S" and get_node("SelectionScreen/FrogGrade").text == "S" and get_node("SelectionScreen/WhaleGrade").text == "S" and get_node("SelectionScreen/LionGrade").text == "S":
		show_credits()
	else:
		scene_transition(scene, $SelectionScreen)
		scene.get_node("Label").reset()

func go_to_battle(battle):
	$Fade.show()
	$Tween.interpolate_property($Fade,"modulate",Color.transparent,Color.white,1.0);
	$Tween.start();
	yield($Tween,"tween_completed")
	battle.show()
	$SelectionScreen.hide()
	battle.play()
	$Tween.interpolate_property($Fade,"modulate",Color.white,Color.transparent,1.0);
	$Tween.start();
	yield($Tween,"tween_completed")
	$Fade.hide()

func show_score(battle):
	var scoring = battle.get_node("Label")
	
	$ScoreScreen.reset_screen()
	var score_label = $SelectionScreen.get_node(battle.name.substr(6) + "Score")
	var grade_label = $SelectionScreen.get_node(battle.name.substr(6) + "Grade")

	$ScoreScreen.update_scores(scoring.points, scoring.total_beats, scoring.beats_hit, battle.leftcharacter.name, score_label, grade_label)
		
	scene_transition(battle, $ScoreScreen)
	scoring.reset()
	
func show_credits():
	scene_transition($ScoreScreen, $Choir)
	get_node("Choir/ChoirSong").play()
	yield(get_tree().create_timer(84), "timeout")
	scene_transition($Choir, $Credits)
	get_node("Choir/ChoirSong").play()

func scene_transition(old_scene, new_scene):
	$Fade.show()
	$Tween.interpolate_property($Fade,"modulate",Color.transparent,Color.white,1.0);
	$Tween.start();
	yield($Tween,"tween_completed")
	new_scene.show()
	old_scene.hide()
	$Tween.interpolate_property($Fade,"modulate",Color.white,Color.transparent,1.0);
	$Tween.start();
	yield($Tween,"tween_completed")
	$Fade.hide()
	

func _on_Sapa_pressed():
	go_to_battle($VersusFrog)

func _on_Morcegue_pressed():
	go_to_battle($VersusBat)

func _on_Leoa_pressed():
	go_to_battle($VersusLion)

func _on_Beluga_pressed():
	go_to_battle($VersusWhale)

func _on_PlayAgain_pressed():
	scene_transition($Credits, $TitleScreen)

func _on_Start_pressed():
	scene_transition($TitleScreen, $SelectionScreen)
