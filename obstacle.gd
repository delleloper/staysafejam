extends Area2D
class_name obstacle

export var damage : int = 1

func _ready():
	pass

func _on_obstacle_body_entered(body):
	if body.is_in_group("player"):
		body.hp -= damage
		body.get_node("Camera2D").add_trauma(0.5)
	pass
