extends Control

enum sigma{
	enter,
	config,
	exit
}

var choosen_var = sigma.enter
var game_manager

func _ready():
	if game_manager == null:
		game_manager = get_tree().get_root().get_node("GameManager")
	get_viewport().size = Vector2(720, 686)

func _input(event):
	if event.is_action_pressed("ui_up"):
		@warning_ignore('int_as_enum_without_cast')
		choosen_var -= 1
		if choosen_var == -1:
			@warning_ignore('int_as_enum_without_cast')
			choosen_var = 2
	elif event.is_action_pressed("ui_down"):
		@warning_ignore('int_as_enum_without_cast')
		choosen_var += 1
		if choosen_var == 3:
			@warning_ignore('int_as_enum_without_cast')
			choosen_var = 0
			
	if event.is_action_pressed("ui_accept"):
		match choosen_var:
			sigma.enter:
				loadedscript.currentlevel = loadedscript.levels.grass
				visible = false
				game_manager.goto_scene("res://scenes/mainscene.tscn")
			sigma.config:
				visible = false
				game_manager.goto_scene("res://scenes/UI/menu.tscn")
			sigma.exit:
				get_tree().quit()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if game_manager.current_track != "title_screen":
		game_manager.change_music_track("title_screen")
	
	match choosen_var:
		sigma.enter:
			#loadedscript.currentlevel = loadedscript.levels.grass
			#visible = false
			#get_tree().change_scene_to_file("res://scenes/mainscene.tscn")
			$CenterContainer/AspectRatioContainer/AnimatedSprite2D.play("shovel")
		sigma.config:
			$CenterContainer/AspectRatioContainer/AnimatedSprite2D.play("sigmamode")
			#visible = false
			#get_tree().change_scene_to_file("res://scenes/UI/menu.tscn")
		sigma.exit:
			$CenterContainer/AspectRatioContainer/AnimatedSprite2D.play("yeah")
	pass
