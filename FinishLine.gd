extends Area2D

export var id = 0
var dialog

func _on_FinishLine_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		GM.triggerDialog(dialog)
		body.running = false

func _ready() -> void:
	dialog = obtainDialog(id)

func obtainDialog(id):
	return "Its dangerous to go alone take this"