extends KinematicBody2D

export var hp = 3

func _process(delta):
	if hp <= 0:
		queue_free()

func _on_Hitbox_area_entered(area):
	if area.is_in_group("attack"):
		self.hp -= area.damage
