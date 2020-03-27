extends Camera2D
class_name ShakeCamera2D

export var decay = .8  # How quickly the shaking stops [0, 1].
export var rollDecay = .2
export var rollIncrement = .1
export var max_offset = Vector2(.5, .5)  # Maximum hor/ver shake in pixels.
export var max_roll = .1  # Maximum rotation in radians (use sparingly).
export var initialZoom = Vector2.ONE

onready var noise = OpenSimplexNoise.new()
var trauma = 0.0  # Current shake strength.
var trauma_power = 2  # Trauma exponent. Use [2, 3].
var noise_y = 0
var zoomOffset : Vector2
var rollDirection = 0

func _ready():
	randomize()
	noise.seed = randi()
	noise.period = 4
	noise.octaves = 2
	initialZoom = zoom

func _physics_process(delta):
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		shake()
	else:
		zoom =lerp(zoom,initialZoom,get_physics_process_delta_time()*2.5)
	rotation = 0 + rollDirection * .2
	if rollDirection > 0:
		rollDirection = max(rollDirection - decay * delta, 0)
	if rollDirection < 0:
		rollDirection = min(rollDirection + decay * delta, 0)
func shake():
	var amount = pow(trauma, trauma_power)
	noise_y += 1
	zoom = lerp(zoom,Vector2(0.3,0.3),get_physics_process_delta_time()*2.5)

func add_trauma(amount):
	trauma = min(trauma + amount, 1.0)

func inc_roll():
	rollDirection = min(rollDirection + rollIncrement, 1.0)
func dec_roll():
	rollDirection = max(rollDirection - rollIncrement, -1.0)
