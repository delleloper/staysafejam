extends Panel

signal start_game

func _ready():
	AM.play_main_theme()
	$MarginContainer/HBoxContainer/CenterContainer/Credits.visible = false
	pass

func _on_Play_pressed():
	GM.change_scene(1)

func _on_Credits_pressed():
	$MarginContainer/HBoxContainer/CenterContainer/Credits.visible = !$MarginContainer/HBoxContainer/CenterContainer/Credits.visible
	pass

func _on_Exit_pressed():
	get_tree().quit()

func _process(delta):
	pass
