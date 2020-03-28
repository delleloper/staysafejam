extends Area2D

class_name Item
enum itemTypes {MEDICINE, MASK, FOOD}

var type

func _ready() -> void:
	type = itemTypes.FOOD


func _on_BaseItem_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		body.addItem(self)