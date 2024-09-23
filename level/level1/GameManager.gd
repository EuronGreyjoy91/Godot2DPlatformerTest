extends Node

@export var points_label: Label
@export var apples_list: Node


func _ready():
	for apple in apples_list.get_children():
		if apple.has_signal("apple_collected"):
			apple.connect("apple_collected", self._on_apple_collected)


func _on_apple_collected() -> void:
	var points: int = points_label.text.to_int()
	points_label.text = str(points + 1)
