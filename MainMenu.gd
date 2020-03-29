extends Panel

signal start_game

func _ready():
	AM.play_main_theme()
	pass

func _on_Play_pressed():
	GM.change_scene(1)

func _on_Credits_pressed():
	print("Credits_pressed")
	pass

func _on_Exit_pressed():
	get_tree().quit()

func on_CreditsOver():
	pass

func _process(delta):
	pass
