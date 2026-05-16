extends CanvasLayer

@onready var hud = $HUD
@onready var pause_menu = $PauseMenu
@onready var game_over = $GameOver
@onready var score_label = %ScoreLabel
@onready var kills_label = %KillsLabel
@onready var high_score_label = %HighScoreLabel

func set_score(value: int) -> void:
	score_label.text = "SCORE: " + str(value)

func set_kills(value: int) -> void:
	kills_label.text = "KILLS: " + str(value)

func show_pause(state: bool) -> void:
	pause_menu.visible = state

func show_game_over() -> void:
	game_over.visible = true
	pause_menu.visible = false

func hide_all_overlays() -> void:
	game_over.visible = false
	pause_menu.visible = false

func _on_retry_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
	
func set_high_score(value: int) -> void:
	high_score_label.text = "HIGH SCORE: " + str(value)
