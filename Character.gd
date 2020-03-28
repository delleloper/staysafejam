extends KinematicBody2D

var dialog

func _ready() -> void:
	dialog = obtainDialog()

func _on_Hitbox_body_entered(area: Node) -> void:
	if area.is_in_group("player"):
		GM.triggerDialog(dialog)

func obtainDialog():
	return "Its dangerous to go alone take this"
