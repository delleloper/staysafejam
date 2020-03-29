extends Node

var scene_array : Array = [load("res://StoryScreen.tscn"), 
load("res://Game.tscn"),
load("res://Game2.tscn"),
load("res://Game3.tscn"),
load("res://Game4.tscn"),
load("res://Game5.tscn")]

var current_scene = 0

var current_key = "start"

var UI
var player
var full = false

func _ready() -> void:
	OS.window_fullscreen = full

func triggerDialog(dialog):
	UI.displayDialog(dialog)
	print(dialog)

###---old method---###
#func change_scene():
#	get_tree().change_scene_to(scene_array[current_scene])
#	current_scene += 1
#	pass

func change_scene(_scene_index):
	get_tree().change_scene_to(scene_array[_scene_index])
	pass
