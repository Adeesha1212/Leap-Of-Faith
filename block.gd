extends Node2D

@export var move_distance := 100.0  # how far it moves up/down
@export var move_speed := 5.0       # speed of movement
@export var wait_time := 0.05      # time to pause at top/bottom

var start_position: Vector2
var target_position: Vector2
var moving_up := true
var timer := 0.0
var waiting := false

func _ready():
	start_position = global_position
	target_position = start_position - Vector2(0, move_distance)

func _process(delta):
	if waiting:
		timer -= delta
		if timer <= 0:
			waiting = false
			moving_up = !moving_up
			if moving_up:
				target_position = start_position - Vector2(0, move_distance)
			else:
				target_position = start_position
		return

	global_position = global_position.lerp(target_position, move_speed * delta)

	# Check if we reached target
	if global_position.distance_to(target_position) < 1.0:
		global_position = target_position
		waiting = true
		timer = wait_time
