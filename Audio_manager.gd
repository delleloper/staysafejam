extends Node

func _ready():
	play_main_theme()
#	play_gamplay()
	pass

func play_main_theme():
	$Tween.remove_all()
	$Tween.interpolate_property($player_main_theme, "volume_db", $player_main_theme.volume_db, 0.0, 1.0, Tween.TRANS_SINE, Tween.EASE_OUT)
	$Tween.interpolate_property($player_gameplay, "volume_db", $player_gameplay.volume_db, -90.0, 1.0, Tween.TRANS_SINE, Tween.EASE_OUT)
	$Tween.start()
	
	if !$player_main_theme.is_playing():
		$player_main_theme.play()
	else:
		$player_main_theme.set_stream_paused(false)
	
	yield($Tween, "tween_all_completed")
	$player_gameplay.set_stream_paused(true)

func play_gamplay():
	$Tween.remove_all()
	$Tween.interpolate_property($player_gameplay, "volume_db", $player_gameplay.volume_db, 0.0, 1.0, Tween.TRANS_SINE, Tween.EASE_OUT)
	$Tween.interpolate_property($player_main_theme, "volume_db", $player_main_theme.volume_db, -90.0, 1.0, Tween.TRANS_SINE, Tween.EASE_OUT)
	$Tween.start()
	
	if !$player_gameplay.is_playing():
		$player_gameplay.play()
	else:
		$player_gameplay.set_stream_paused(false)
	pass
	
	yield($Tween, "tween_all_completed")
	$player_main_theme.set_stream_paused(true)



###---just for debug---###
#func _process(delta):
#	if Input.is_action_just_pressed("move_down"):
#		play_gamplay()
#
#	if Input.is_action_just_pressed("move_up"):
#		play_main_theme()
#
#	print($player_main_theme.stream_paused)
#	pass
