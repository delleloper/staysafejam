extends Panel

#signal start_game

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_OptionA_pressed():
	print("OptionA_pressed")
	#emit_signal("start_game", ...)

func _on_OptionB_pressed():
	print("OptionB_pressed")
	#emit_signal("start_game", ...)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
