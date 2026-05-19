extends StaticBody2D

func _ready():
	scale *= randf_range(0.8, 1.3)
	rotation_degrees = randf_range(-5, 5)
