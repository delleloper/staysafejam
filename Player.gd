extends KinematicBody2D
enum side {LEFT, MIDDLE, RIGHT}

class_name Player

onready var cam = $Camera2D

const ACCELERATION = 120
const SLIDE_ACCELERATION = 600
const MAX_SPEED = 600
const FRICTION = 500

export var hp = 3 setget setHp

var velocity = Vector2.ZERO
var inventory = [3]
var running = true
var currentSide = side.MIDDLE
var reachedEnd = false
var slideValue = 180
var slideAmount = 0
var vulnerable = true

signal game_failed
signal game_succeded

func _ready() -> void:
	inventory.resize(Item.itemTypes.size())
	for i in inventory.size():
		inventory[i] = 0
	GM.player = self

func _process(delta: float) -> void:
	if reachedEnd:
		running = false
		$Camera2D.position.y = 0
	else:
		$Camera2D.position.y = -225
	if true:
		emit_signal("game_succeded")
	else:
		emit_signal("game_failed")


func _physics_process(_delta: float) -> void:
	var inputVector = Vector2.ZERO
	if running:
		inputVector.y = -1
		if Input.is_action_just_pressed("move_left") && (currentSide != side.LEFT):
	#		var PosX = position.x - slideValue
	#		tw.interpolate_property(self,"position",position,Vector2(PosX, position.y-20),.1)
	#		tw.start()
			#I know is not the correct way but it works ¯\_(ツ)_/¯  we can fix later
			translate(Vector2(-slideValue,0))
	#		velocity.x = -SLIDE_ACCELERATION
			if currentSide == side.MIDDLE:
				currentSide = side.LEFT
			else:
				currentSide = side.MIDDLE

		if Input.is_action_just_pressed("move_right") && (currentSide != side.RIGHT):
	#		#I know is not the correct way but it works ¯\_(ツ)_/¯  we can fix later
	#		var PosX = position.x + slideValue
	#		tw.interpolate_property(self,"position",position,Vector2(PosX, position.y-20),.1)
	#		tw.start()
			translate(Vector2(slideValue,0))
	#		velocity.x += SLIDE_ACCELERATION
			if currentSide == side.MIDDLE:
				currentSide = side.RIGHT
			else:
				currentSide = side.MIDDLE
	else:
		inputVector.y = 0
	if inputVector != Vector2.ZERO:
		velocity = velocity.move_toward(inputVector * MAX_SPEED, ACCELERATION * _delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO,FRICTION * _delta)

	velocity = move_and_slide(velocity)

func die():
	queue_free()
	yield(get_tree().create_timer(3),"timeout")
#	get_tree().change_scene("res://MainMenu.tscn")
	get_tree().reload_current_scene()

func addItem(_item :Item):
	print(Item.itemTypes.keys()[_item.type])
	inventory[_item.type] += 1
	GM.UI._update_items(inventory)

func setHp(amount):
	if vulnerable:
		hp = amount
		GM.UI._update_hp_bar(hp)
		AM.apply_filter()
		if hp <= 0:
			die()
		vulnerable = false
		$PlayerAnimator.play("damage")
		yield($PlayerAnimator,"animation_finished")
		vulnerable = true


