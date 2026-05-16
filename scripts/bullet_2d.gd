extends Area2D

const IMPACT = preload("res://scenes/impact.tscn")
var travelled_distance = 0

func _ready():
	process_mode = Node.PROCESS_MODE_PAUSABLE

func _physics_process(delta):
	const SPEED = 1000
	const RANGE = 1200
	position += Vector2.RIGHT.rotated(rotation) * SPEED * delta
	travelled_distance += SPEED * delta
	if travelled_distance > RANGE:
		queue_free()

func _on_body_entered(body):
	var impact = IMPACT.instantiate()
	impact.process_mode = Node.PROCESS_MODE_PAUSABLE
	get_tree().current_scene.add_child(impact)
	impact.global_position = global_position
	if body.has_method("take_damage"):
		body.take_damage()
	queue_free()
