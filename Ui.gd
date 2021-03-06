extends Control

onready var text = $Panel/Dialog
var displaying = false
var percent = 0

var green : Color = Color("67c32f")
var red : Color = Color("c32f2f")

func _ready() -> void:
	GM.UI = self
	visible = true
	AM.play_gameplay()

func displayDialog(dialog):
	text.text = dialog
	text.percent_visible = percent
	$AnimationPlayer.play("ShowDialog")
	yield($AnimationPlayer, "animation_finished")
	displaying = true

func hideDialog():
	$AnimationPlayer.play_backwards("ShowDialog")
	percent = 0
	GM.change_scene(0)

func _process(delta: float) -> void:
	if displaying:
		percent += delta
		text.percent_visible = percent
		if percent >= 1:
			displaying = false
			yield(get_tree().create_timer(2), "timeout")
			hideDialog()

func _update_hp_bar(_hp : int):
	$health_bar/Tween.interpolate_property($health_bar, "value", _hp +1, _hp, 0.4, Tween.TRANS_BACK, Tween.EASE_OUT)
	$health_bar/Tween.interpolate_property($health_bar, "tint_progress", red, green, 0.6, Tween.TRANS_EXPO, Tween.EASE_OUT)
	$health_bar/Tween.start()
	pass
	
func _update_items(_inventory):
	for i in range(0, 3):
		$item_bar.get_child(i).get_node("Label").text = str(_inventory[i])
		pass
	pass
