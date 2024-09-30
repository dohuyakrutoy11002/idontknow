extends Node2D

@onready var background: AnimatedSprite2D = $AnimatedSprite2D

var game_manager

func _ready() -> void:
	get_viewport().size = Vector2(1152, 648)
	if game_manager == null:
		game_manager = get_tree().get_root().get_node("GameManager")
	_set_background()

#For testing
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed('pause'):
		game_manager.goto_scene('res://scenes/UI/sigmamenu.tscn')
	if event.is_action_pressed("T"):
		Engine.max_fps = 10
	elif event.is_action_released("T"):
		Engine.max_fps = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if game_manager.current_track != game_manager.current_level["track_name"]:
		game_manager.change_music_track(game_manager.current_level["track_name"])


func _set_background() -> void:
	background.animation = game_manager.current_level["level_background"]
	background.play()
