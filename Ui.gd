extends Control

onready var text = $Panel/Dialog
var displaying = false

func _ready() -> void:
	GM.UI = self

func displayDialog(dialog):
	$AnimationPlayer.play("ShowDialog")
	yield($AnimationPlayer, "animation_finished")
	text.text = dialog
	text.percent_visible = 0
	displaying = true


func hideDialog():
	$AnimationPlayer.play_backwards("ShowDialog")

func _process(delta: float) -> void:

	if displaying:
		text.percent_visible = lerp(text.percent_visible, 1, delta/2)
