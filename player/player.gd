extends CharacterBody2D


const SPEED = 900.00
const JUMP_VELOCITY = -500.0
const MAX_JUMPS_COUNT = 2
const SLIDING_SPEED = 0.01
const MAX_SLIDING = 1

var number_of_jumps:int = MAX_JUMPS_COUNT
var acceleration:float = 0

func _ready() -> void:
	number_of_jumps = MAX_JUMPS_COUNT

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and number_of_jumps > 0:
		number_of_jumps = number_of_jumps - 1
		$Label.text = String.num_int64(number_of_jumps)
		velocity.y = JUMP_VELOCITY
	elif is_on_floor():
		number_of_jumps = MAX_JUMPS_COUNT
		$Label.text = String.num_int64(number_of_jumps)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		acceleration = acceleration + SLIDING_SPEED
		velocity.x = direction * SPEED * (1 + acceleration)
		print(direction)
	else:
		velocity.x = direction * SPEED * (1 + acceleration)

	move_and_slide()
