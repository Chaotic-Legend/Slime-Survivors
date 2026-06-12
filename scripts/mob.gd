extends CharacterBody2D

signal died

@onready var slime_sound = $SlimeSound
@onready var hurt_sound = $HurtSound
@onready var player = get_node("/root/Game/Player")

var speed = randf_range(200, 350)
var health = 3

func _ready():
	process_mode = Node.PROCESS_MODE_PAUSABLE
	%Slime.play_walk()

func _physics_process(_delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	move_and_slide()

func take_damage():
	if health <= 0:
		return
	%Slime.play_hurt()
	hurt_sound.pitch_scale = randf_range(0.9, 1.1)
	hurt_sound.play()
	health -= 1
	if health <= 0:
		died.emit()
		slime_sound.reparent(get_tree().current_scene)
		slime_sound.global_position = global_position
		slime_sound.play()
		slime_sound.finished.connect(slime_sound.queue_free)
		var smoke_scene = preload("res://scenes/smoke_explosion.tscn")
		var smoke = smoke_scene.instantiate()
		smoke.process_mode = Node.PROCESS_MODE_PAUSABLE
		get_parent().add_child(smoke)
		smoke.global_position = global_position
		queue_free()
