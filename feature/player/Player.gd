extends CharacterBody2D

const GRAVITY_SPEED: float = 1100
const HORIZONTAL_SPEED: float = 8000
const JUMP_SPEED: float = -350

@export var animated_sprite_2d: AnimatedSprite2D

var jumps_count: int = 0
var horizontal_direction: int = 0


func _physics_process(delta) -> void:
	if !is_on_floor():
		velocity.y += GRAVITY_SPEED * delta

	if is_on_floor():
		jumps_count = 0

	handle_jump_input()
	handle_horizontal_input()
	handle_horizontal_movement_animations()
	handle_fall_animation()
	flip_sprite()

	velocity.x = horizontal_direction * HORIZONTAL_SPEED * delta
	move_and_slide()


func handle_jump_input() -> void:
	if !has_reached_jumps_limit() and Input.is_action_just_pressed("jump"):
		if jumps_count == 0:
			animated_sprite_2d.play("jump")
		else:
			animated_sprite_2d.play("double_jump")

		velocity.y = JUMP_SPEED
		jumps_count += 1


func has_reached_jumps_limit() -> bool:
	return jumps_count >= 2


func handle_horizontal_input() -> void:
	if Input.is_action_pressed("move_left"):
		horizontal_direction = -1
	elif Input.is_action_pressed("move_right"):
		horizontal_direction = 1
	else:
		horizontal_direction = 0


func handle_horizontal_movement_animations() -> void:
	if velocity.y == 0:
		if velocity.x == 0:
			animated_sprite_2d.play("idle")
		else:
			animated_sprite_2d.play("run")


func handle_fall_animation() -> void:
	if velocity.y > 0:
		animated_sprite_2d.play("fall")


func flip_sprite() -> void:
	if horizontal_direction == -1:
		animated_sprite_2d.flip_h = true
	elif horizontal_direction == 1:
		animated_sprite_2d.flip_h = false

