class_name Character
extends Node2D

var is_dancing: bool = true

func _ready():
	pass # Replace with function body.

func on_beat():
	if is_dancing:
		$AnimationPlayer.seek(0)
		$AnimationPlayer.play("dance")

func dance():
	$Sing.hide()
	$Idle.show()
	$Sustain.hide()
	$Error.hide()
	is_dancing = true

func sing():
	$Sing.show()
	$Idle.hide()
	$Sustain.hide()
	$Error.hide()
	$AnimationPlayer.seek(0)
	$AnimationPlayer.play("sing_note")
	is_dancing = false
	yield($AnimationPlayer,"animation_finished")
	is_dancing = true

func error():
	$Sing.hide()
	$Idle.hide()
	$Sustain.hide()
	$Error.show()
#	$AnimationPlayer.seek(0)
	$AnimationPlayer.play("error")
	is_dancing = false
	yield($AnimationPlayer,"animation_finished")
	is_dancing = true

func power_sing():
	$Sing.hide()
	$Idle.hide()
	$Sustain.show()
	$Error.hide()
