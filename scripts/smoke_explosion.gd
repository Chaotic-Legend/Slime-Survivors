extends Node2D

@onready var smoke = $Smoke
@onready var anim = $AnimationPlayer

func _ready():
	process_mode = Node.PROCESS_MODE_PAUSABLE
	smoke.material.set_shader_parameter(
		"texture_offset",
		Vector2(randf_range(0.0, 1.0), randf_range(0.0, 1.0)))
	anim.play("explosion")
	await anim.animation_finished
	queue_free()
