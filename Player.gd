extends KinematicBody2D

onready var cam = $Camera2D
const ACCELERATION = 500
const MAX_SPEED = 230
const FRICTION = 500
var velocity = Vector2.ZERO
var full = false
var inventory
export var hp = 3

func _ready() -> void:
	OS.window_fullscreen = full

func _process(_delta: float) -> void:
	if hp <= 0:
		die()
	var inputVector = Vector2.ZERO
	inputVector.x = Input.get_action_strength("move_right") - Input.get_action_strength('move_left')
#	inputVector.y = Input.get_action_strength("move_down") - Input.get_action_strength('move_up')
	inputVector.y = -1
	inputVector = inputVector.normalized()
	if inputVector != Vector2.ZERO:
		velocity = velocity.move_toward(inputVector * MAX_SPEED, ACCELERATION * _delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO,FRICTION * _delta)
	if Input.is_action_just_pressed("move_left"):
		 velocity.x = -1 * ACCELERATION
	if Input.is_action_just_pressed("move_right"):
		 velocity.x = 1 * ACCELERATION
	velocity = move_and_slide(velocity)

func die():
	queue_free()

func addItem(item :Item):
	pass
