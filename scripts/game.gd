extends Node2D

@onready var player = $Player
@onready var ui = $UI

const MAX_MOBS := 50
var high_score := 0
var mob_count := 0
var paused := false
var game_over := false
var score := 0
var kills := 0

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	ui.hide_all_overlays()
	ui.set_score(0)
	ui.set_kills(0)
	load_high_score()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("reset_high_score"):
		high_score = 0
		save_high_score()
		ui.set_high_score(high_score)
	if game_over:
		if event.is_action_pressed("reset"):
			get_tree().paused = false
			get_tree().reload_current_scene()
		if event.is_action_pressed("quit"):
			get_tree().quit()
		return
	if event.is_action_pressed("pause"):
		paused = !paused
		get_tree().paused = paused
		ui.show_pause(paused)
	if event.is_action_pressed("reset"):
		get_tree().paused = false
		get_tree().reload_current_scene()
	if event.is_action_pressed("quit"):
		get_tree().quit()

func spawn_mob() -> void:
	if mob_count >= MAX_MOBS:
		return
	%PathFollow2D.progress_ratio = randf()
	var new_mob = preload("res://scenes/mob.tscn").instantiate()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)
	mob_count += 1
	new_mob.tree_exited.connect(_on_mob_tree_exited)
	new_mob.died.connect(_on_mob_died)

func _on_mob_tree_exited() -> void:
	mob_count = max(mob_count - 1, 0)

func _on_mob_died() -> void:
	score += 50
	kills += 1
	ui.set_score(score)
	ui.set_kills(kills)

func _on_timer_timeout() -> void:
	spawn_mob()

func _on_player_health_depleted() -> void:
	$Player/Gun/Timer.stop()
	var smoke_scene = preload("res://scenes/smoke_explosion.tscn")
	var smoke = smoke_scene.instantiate()
	smoke.process_mode = Node.PROCESS_MODE_PAUSABLE
	add_child(smoke)
	smoke.global_position = player.global_position
	player.hide()
	player.set_physics_process(false)
	player.set_process(false)
	if score > high_score:
		high_score = score
		save_high_score()
	ui.set_high_score(high_score)
	await get_tree().create_timer(1.0).timeout
	ui.show_game_over()
	game_over = true
	get_tree().paused = true
	paused = true
	
func save_high_score() -> void:
	var file = FileAccess.open("user://save.dat", FileAccess.WRITE)
	if file:
		file.store_32(high_score)
		file.close()

func load_high_score() -> void:
	if FileAccess.file_exists("user://save.dat"):
		var file = FileAccess.open("user://save.dat", FileAccess.READ)
		if file:
			high_score = file.get_32()
			file.close()
