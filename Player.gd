extends KinematicBody2D

onready var cam = $Camera2D
const ACCELERATION = 500
const MAX_SPEED = 230
const FRICTION = 500
var velocity = Vector2.ZERO
var full = false
var inventory

func _ready() -> void:
	OS.window_fullscreen = full

func _process(_delta: float) -> void:
	var inputVector = Vector2.ZERO
	inputVector.x = Input.get_action_strength("move_right") - Input.get_action_strength('move_left')
	inputVector.y = Input.get_action_strength("move_down") - Input.get_action_strength('move_up')
	inputVector = inputVector.normalized()
	if inputVector != Vector2.ZERO:
		velocity = velocity.move_toward(inputVector * MAX_SPEED, ACCELERATION * _delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO,FRICTION * _delta	)
	velocity = move_and_slide(velocity)

