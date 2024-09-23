extends Node2D

const GRAVITY_SPEED: float = 250

@export var gpu_particles_2d: GPUParticles2D
@export var animation_player: AnimationPlayer
@export var animated_sprite_2d: AnimatedSprite2D
@export var fall_timer: Timer
@export var destroy_timer: Timer
@export var platform_collider: CollisionShape2D

var falling: bool = false

func _physics_process(delta) -> void:
	if falling:
		translate(Vector2.DOWN * delta * GRAVITY_SPEED)


func _on_deactivate_detector_body_entered(body) -> void:
	if body.name == "Player":
		gpu_particles_2d.emitting = false
		animation_player.stop()
		animated_sprite_2d.play("stopped")
		fall_timer.start()


func _on_fall_timer_timeout() -> void:
	falling = true
	platform_collider.disabled = true
	destroy_timer.start()


func _on_destroy_timer_timeout() -> void:
	queue_free()
