extends Control
	
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


func _on_Sapa_pressed():
	go_to_battle($VersusFrog)

func _on_Morcegue_pressed():
	go_to_battle($VersusBat)

func _on_Leoa_pressed():
	go_to_battle($VersusLion)

func _on_Beluga_pressed():
	go_to_battle($VersusWhale)
