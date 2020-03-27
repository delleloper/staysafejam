extends KinematicBody2D

onready var cam = $Camera2D
const ACCELERATION = 500
const MAX_SPEED = 100
const FRICTION = 500
var velocity = Vector2.ZERO
var full = false

func _ready() -> void:
	OS.window_fullscreen = full

func _process(_delta: float) -> void:
	var inputVector = Vector2.ZERO
	inputVector.x = Input.get_action_strength("move_right") - Input.get_action_strength('move_left')
	inputVector.y = Input.get_action_strength("move_down") - Input.get_action_strength('move_up')
	inputVector = inputVector.normalized()
	if Input.is_action_pressed("move_right") || Input.is_action_pressed('move_down'):
		cam.inc_roll()
	if Input.is_action_pressed('move_left') || Input.is_action_pressed('move_up'):
		cam.dec_roll()
	if inputVector != Vector2.ZERO:
		velocity = velocity.move_toward(inputVector * MAX_SPEED, ACCELERATION * _delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO,FRICTION * _delta	)
	velocity = move_and_slide(velocity)

	if Input.is_action_pressed("attack"):
		$WeaponGuide/WeaponAnimation.play("attack")

	if velocity.length() > 0:
		$PlayerAnimator.play("walk")
	else:
		$PlayerAnimator.play("idle")
	cam.add_trauma(velocity.length()/200)
	updateWeaponPos()

func updateWeaponPos():
	var mousePosition = get_global_mouse_position()
	$WeaponGuide.look_at(mousePosition)
