extends Node

var filter_running : bool = false

func _ready():
	pass

func play_main_theme():
	$Tween.remove_all()
	$Tween.interpolate_property($player_main_theme, "volume_db", $player_main_theme.volume_db, 0.0, 1.0, Tween.TRANS_SINE, Tween.EASE_OUT)
	$Tween.interpolate_property($player_gameplay, "volume_db", $player_gameplay.volume_db, -90.0, 1.0, Tween.TRANS_SINE, Tween.EASE_OUT)
	$Tween.start()
	
	if !$player_main_theme.is_playing():
		$player_main_theme.play()
		$player_main_theme.set_stream_paused(false)
	else:
		$player_main_theme.set_stream_paused(false)
	
#	yield($Tween, "tween_all_completed") ###---> yield couses a sound bug, where you cange the music to fast the music would stop plaing
	$player_gameplay.set_stream_paused(true)

func play_gameplay():
	$Tween.remove_all()
	$Tween.interpolate_property($player_main_theme, "volume_db", $player_main_theme.volume_db, -90.0, 1.0, Tween.TRANS_SINE, Tween.EASE_OUT)
	$Tween.interpolate_property($player_gameplay, "volume_db", $player_gameplay.volume_db, 0.0, 1.0, Tween.TRANS_SINE, Tween.EASE_OUT)
	$Tween.start()

	if !$player_gameplay.is_playing():
		$player_gameplay.play()
		$player_gameplay.set_stream_paused(false)
	else:
		$player_gameplay.set_stream_paused(false)

#	yield($Tween, "tween_all_completed") ###---> yield couses a sound bug, where you cange the music to fast the music would stop plaing
	$player_main_theme.set_stream_paused(true)

func apply_filter():
	if filter_running == true:
		return
	
	var pass_min : float = 500.0
	var pass_max : float = 8000.0
	
	AudioServer.set_bus_effect_enabled(1,0, true)
	AudioServer.get_bus_effect(1, 0).cutoff_hz =  pass_min
	filter_running = true

	yield(get_tree().create_timer(0.2), "timeout")
	$Tween.interpolate_property(AudioServer.get_bus_effect(1, 0), "cutoff_hz", pass_min, pass_max, 0.4, Tween.TRANS_EXPO, Tween.EASE_IN)
	$Tween.start()
	
	yield(get_tree().create_timer(0.5), "timeout")
	AudioServer.set_bus_effect_enabled(1,0, false)
	filter_running = false
	pass

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
