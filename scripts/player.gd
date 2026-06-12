extends CharacterBody2D

signal health_depleted

@onready var health_bar = $HealthBar
@onready var death_sound = $DeathSound

const MAX_HEALTH := 100.0
const SPEED := 600.0
const SPRINT_MULTIPLIER := 1.5
const DAMAGE_RATE := 6.0
const FULL_COLOR := Color("#9fdd51")
const LOW_COLOR := Color("#9f0000")

var health := 100.0
var fill_style: StyleBoxFlat
var ratio: float = 1.0

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_PAUSABLE
	fill_style = health_bar.get_theme_stylebox("fill") as StyleBoxFlat
	fill_style = fill_style.duplicate() as StyleBoxFlat
	health_bar.add_theme_stylebox_override("fill", fill_style)
	health_bar.max_value = MAX_HEALTH
	health_bar.value = health
	fill_style.bg_color = FULL_COLOR

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var current_speed = SPEED
	if Input.is_action_pressed("sprint"):
		current_speed *= SPRINT_MULTIPLIER
	velocity = direction * current_speed
	move_and_slide()
	if velocity.length() > 0.0:
		%HappyBoo.play_walk_animation()
	else:
		%HappyBoo.play_idle_animation()
	var overlapping_mobs = $HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		health = clamp(health, 0.0, MAX_HEALTH)
		update_health_ui()
		if health <= 0.0:
			death_sound.play()
			health_depleted.emit()

func _process(_delta):
	if ratio < 0.40:
		var speed := 0.01
		if ratio < 0.25:
			speed *= 2.0
		if ratio < 0.10:
			speed *= 2.5
		var t: float = Time.get_ticks_msec() * speed
		var pulse: float = (sin(t) + 1.0) * 0.5
		var white_overlay: Color = Color(1, 1, 1, 1).lerp(Color(1, 1, 1, 0), pulse * 0.5)
		fill_style.bg_color = LOW_COLOR.lerp(white_overlay, pulse * 0.35)
	else:
		fill_style.bg_color = FULL_COLOR.lerp(LOW_COLOR, 1.0 - ratio)

func update_health_ui() -> void:
	health_bar.value = health
	ratio = health / MAX_HEALTH
