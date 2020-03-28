extends Node

var UI
var player
var full = false

func _ready() -> void:
	OS.window_fullscreen = full

func triggerDialog(dialog):
	UI.displayDialog(dialog)
	print(dialog)
