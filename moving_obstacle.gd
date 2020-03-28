extends Path2D

class_name moving_obstacle

export var speed = 0.2

func _physics_process(delta):
	$PathFollow2D.unit_offset += speed * delta
	pass
