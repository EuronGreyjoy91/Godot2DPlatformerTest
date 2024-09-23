extends Node2D

signal apple_collected

@export var animated_sprite_2d: AnimatedSprite2D

var collected: bool = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player" and !collected:
		collected = true
		apple_collected.emit()
		animated_sprite_2d.play("collected")


func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "collected":
		queue_free()
