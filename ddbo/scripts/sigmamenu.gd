extends Control

enum sigma{
	enter,
	config,
	exit
}
var choosen_var = sigma.enter

func _ready():
	get_viewport().size = Vector2(720, 686)

func _input(event):
	if event.is_action_pressed("ui_up"):
		choosen_var -= 1
		if choosen_var == -1:
			choosen_var = 2
	elif event.is_action_pressed("ui_down"):
		choosen_var += 1
		if choosen_var == 3:
			choosen_var = 0
			
	if event.is_action_pressed("ui_accept"):
		match choosen_var:
			sigma.enter:
				loadedscript.currentlevel = loadedscript.levels.grass
				visible = false
				get_tree().change_scene_to_file("res://scenes/mainscene.tscn")
			sigma.config:
				visible = false
				get_tree().change_scene_to_file("res://scenes/UI/menu.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
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
