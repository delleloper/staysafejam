extends Control

onready var text = $Panel/Dialog
var displaying = false
var percent = 0

func _ready() -> void:
	GM.UI = self
	visible = true

func displayDialog(dialog):
	text.text = dialog
	text.percent_visible = percent
	$AnimationPlayer.play("ShowDialog")
	yield($AnimationPlayer, "animation_finished")
	displaying = true

func hideDialog():
	$AnimationPlayer.play_backwards("ShowDialog")
	percent = 0

func _process(delta: float) -> void:
	if displaying:
		percent += delta
		text.percent_visible = percent
		if percent >= 1:
			displaying = false
			yield(get_tree().create_timer(2), "timeout")
			hideDialog()
