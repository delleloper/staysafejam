extends Panel

signal start_game

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Play_pressed():
	emit_signal("start_game")

func _on_Credits_pressed():
	print("Credits_pressed")
	pass

func _on_Exit_pressed():
	get_tree().quit()

func on_CreditsOver():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
