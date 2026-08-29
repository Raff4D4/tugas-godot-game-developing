extends CharacterBody2D

const SPEED = 250.0
const JUMP_VELOCITY = -400.0

var max_jumps = 2
var jump_count = 0

var can_dash = true
var is_dashing = false
var dash_speed = 500.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		jump_count = 0

	if Input.is_action_just_pressed("ui_accept") and jump_count < max_jumps:
		velocity.y = JUMP_VELOCITY
		jump_count += 1

	if Input.is_key_pressed(KEY_SHIFT) and can_dash:
		perform_dash()

	var direction := Input.get_axis("left", "right")
	
	var current_speed = dash_speed if is_dashing else SPEED
	if direction:
		velocity.x = direction * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if direction == 1:
		animated_sprite.flip_h = false
	elif direction == -1:
		animated_sprite.flip_h = true

	if not is_on_floor():
		animated_sprite.animation = "jump"
	elif direction != 0:
		animated_sprite.animation = "walk"
	else:
		animated_sprite.animation = "idle"

	move_and_slide()

func perform_dash():
	is_dashing = true
	can_dash = false
	await get_tree().create_timer(0.2).timeout
	is_dashing = false
	await get_tree().create_timer(1.0).timeout
	can_dash = true
