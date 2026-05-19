extends Area2D

@onready var shoot_sound = $ShootSound

const SHOOT_SOUND = preload("res://assets/audio/shoot.wav")
const BULLET = preload("res://scenes/bullet_2d.tscn")
const MUZZLE_FLASH = preload("res://scenes/muzzle_flash.tscn")
var can_shoot := false

func _process(_delta):
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.is_empty():
		return
	var closest_enemy = null
	var closest_distance := INF
	for enemy in enemies_in_range:
		var dist = global_position.distance_to(enemy.global_position)
		if dist < closest_distance:
			closest_distance = dist
			closest_enemy = enemy
	if closest_enemy:
		look_at(closest_enemy.global_position)
	if not can_shoot:
		return

func shoot():
	shoot_sound.pitch_scale = randf_range(0.95, 1.05)
	shoot_sound.play()
	var new_bullet = BULLET.instantiate()
	new_bullet.global_transform = %ShootingPoint.global_transform
	get_tree().current_scene.add_child(new_bullet)
	var flash = MUZZLE_FLASH.instantiate()
	flash.global_transform = %ShootingPoint.global_transform
	flash.top_level = true
	get_tree().current_scene.add_child(flash)

func _on_shoot_timer_timeout() -> void:
	if not can_shoot:
		return
	shoot()
