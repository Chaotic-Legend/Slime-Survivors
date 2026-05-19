extends Node2D

@onready var player = $Player
@onready var gun = $Player/Gun
@onready var spawn_timer = $SpawnTimer
@onready var ui = $UI
@onready var wave_label = $UI/HUD/CenterContainer/WaveLabel
@onready var enemies_left_label = $UI/HUD/MarginContainer/VBoxContainer/EnemiesLeftLabel

const TREE_SCENE := preload("res://scenes/pine_tree.tscn")
const MIN_DISTANCE := 55.0
const CHUNK_SIZE := 650
const TREES_PER_CHUNK := 2
const RENDER_DISTANCE := 3
const MIN_SPAWN_DISTANCE := 120.0

var used_spawn_points: Array[Vector2] = []
var current_wave := 1
var slimes_this_wave := 0
var slimes_spawned := 0
var slimes_killed := 0
var slimes_alive := 0
var wave_active := false
var high_score := 0
var paused := false
var game_over := false
var score := 0
var kills := 0
var generated_chunks := {}

func _process(_delta):
	update_tree_chunks()

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	ui.hide_all_overlays()
	ui.set_score(0)
	ui.set_kills(0)
	load_high_score()
	spawn_trees()
	if wave_label:
		wave_label.visible = false
	spawn_timer.stop()
	call_deferred("start_wave")

func get_valid_spawn_position() -> Vector2:
	var attempts := 10
	while attempts > 0:
		attempts -= 1
		%PathFollow2D.progress_ratio = randf()
		var pos: Vector2 = %PathFollow2D.global_position
		var valid := true
		for p in used_spawn_points:
			if pos.distance_to(p) < MIN_SPAWN_DISTANCE:
				valid = false
				break
		if valid:
			used_spawn_points.append(pos)
			return pos
	return %PathFollow2D.global_position

func start_wave() -> void:
	wave_active = false
	slimes_spawned = 0
	slimes_killed = 0
	slimes_alive = 0
	slimes_this_wave = 10 + (current_wave - 1) * 5
	update_enemies_left_label()
	gun.can_shoot = false
	enemies_left_label.visible = false
	wave_label.text = "WAVE " + str(current_wave)
	wave_label.visible = true
	await get_tree().create_timer(2.0, false).timeout
	wave_label.visible = false
	wave_active = true
	enemies_left_label.visible = true
	gun.can_shoot = true
	spawn_timer.wait_time = 0.6
	spawn_timer.start()

func end_wave() -> void:
	wave_active = false
	gun.can_shoot = false
	current_wave += 1
	await get_tree().create_timer(2.0, false).timeout
	start_wave()

func spawn_mob() -> void:
	if not wave_active:
		return
	if slimes_spawned >= slimes_this_wave:
		return
	%PathFollow2D.progress_ratio = randf()
	var mob = preload("res://scenes/mob.tscn").instantiate()
	mob.global_position = %PathFollow2D.global_position
	add_child(mob)
	slimes_spawned += 1
	slimes_alive += 1
	mob.died.connect(_on_mob_died)
	if slimes_spawned >= slimes_this_wave:
		spawn_timer.stop()

func _on_mob_died() -> void:
	score += 50
	kills += 1
	slimes_killed += 1
	update_enemies_left_label()
	slimes_alive = max(slimes_alive - 1, 0)
	if used_spawn_points.size() > 0:
		used_spawn_points.pop_front()
	ui.set_score(score)
	ui.set_kills(kills)
	if slimes_killed >= slimes_this_wave:
		end_wave()

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
	
func update_enemies_left_label() -> void:
	var enemies_left = slimes_this_wave - slimes_killed
	enemies_left_label.text = "ENEMIES LEFT: " + str(max(enemies_left, 0))

func spawn_trees() -> void:
	update_tree_chunks()

func update_tree_chunks() -> void:
	var player_pos = player.global_position
	var center_chunk = Vector2i(
		floor(player_pos.x / CHUNK_SIZE),
		floor(player_pos.y / CHUNK_SIZE))
	for x in range(center_chunk.x - RENDER_DISTANCE, center_chunk.x + RENDER_DISTANCE + 1):
		for y in range(center_chunk.y - RENDER_DISTANCE, center_chunk.y + RENDER_DISTANCE + 1):
			var chunk_id = Vector2i(x, y)
			if generated_chunks.has(chunk_id):
				continue
			generated_chunks[chunk_id] = true
			spawn_chunk(chunk_id)

func spawn_chunk(chunk: Vector2i) -> void:
	var base = Vector2(chunk.x, chunk.y) * CHUNK_SIZE
	for i in TREES_PER_CHUNK:
		var pos = base + Vector2(
			randf_range(0, CHUNK_SIZE),
			randf_range(0, CHUNK_SIZE))
		var tree = TREE_SCENE.instantiate()
		tree.global_position = pos
		tree.scale = Vector2.ONE
		tree.rotation_degrees = randf_range(-5, 5)
		add_child(tree)
		
func _on_spawn_timer_timeout() -> void:
	spawn_mob()

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
