extends Control

enum sigma{
	enter,
	config,
	exit
}

var choosen_var = sigma.enter
var game_controller: Node2D


func _ready():
	get_viewport().size = Vector2(720, 686)
	game_controller = get_owner()
	game_controller.change_music_track('res://assets/music(finnaly)/Swazz Loop 1 (Title Screen).wav')

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
				game_controller.goto_scene("res://scenes/mainscene.tscn")
			sigma.config:
				visible = false
				game_controller.goto_scene("res://scenes/UI/menu.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
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
