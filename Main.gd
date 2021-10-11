extends Control

func return_to_title(battle):
	$Fade.show()
	$Tween.interpolate_property($Fade,"modulate",Color.transparent,Color.white,1.0);
	$Tween.start();
	yield($Tween,"tween_completed")
	battle.hide()
	$TitleScreen.show()
	$Tween.interpolate_property($Fade,"modulate",Color.white,Color.transparent,1.0);
	$Tween.start();
	yield($Tween,"tween_completed")
	$Fade.hide()
	battle.get_node("Label").reset()

func go_to_battle(battle):
	$Fade.show()
	$Tween.interpolate_property($Fade,"modulate",Color.transparent,Color.white,1.0);
	$Tween.start();
	yield($Tween,"tween_completed")
	battle.show()
	battle.play()
	$TitleScreen.hide()
	$Tween.interpolate_property($Fade,"modulate",Color.white,Color.transparent,1.0);
	$Tween.start();
	yield($Tween,"tween_completed")
	$Fade.hide()

func show_score(battle):
	$Fade.show()
	$Tween.interpolate_property($Fade,"modulate",Color.transparent,Color.white,1.0);
	$Tween.start();
	yield($Tween,"tween_completed")
	battle.hide()
	var scoring = battle.get_node("Label")
	$ScoreScreen.reset_screen()
	$ScoreScreen.update_scores(scoring.points, scoring.total_beats, scoring.beats_hit, battle.leftcharacter.name)
	scoring.points = 0
	scoring.total_beats = 0
	scoring.beats_hit = 0
	$ScoreScreen.show()
	$Tween.interpolate_property($Fade,"modulate",Color.white,Color.transparent,1.0);
	$Tween.start();
	yield($Tween,"tween_completed")
	$Fade.hide()
	battle.get_node("Label").reset()

func _on_Sapa_pressed():
	go_to_battle($VersusFrog)

func _on_Morcegue_pressed():
	go_to_battle($VersusBat)

func _on_Leoa_pressed():
	go_to_battle($VersusLion)

func _on_Beluga_pressed():
	go_to_battle($VersusWhale)
