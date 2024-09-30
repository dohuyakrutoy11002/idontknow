extends Control

var image_t = null

var game_manager

func _ready() -> void:
	if game_manager == null:
		game_manager = get_tree().get_root().get_node("GameManager")
	if game_manager.current_level == game_manager.levels["grass"]:
			$grass.disabled = true
	if game_manager.current_level == game_manager.levels["snow"]:
			$snow.disabled = true
	if game_manager.current_level == game_manager.levels["level"]:
			$level.disabled = true
	$nonlinear.disabled = true

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed('pause'):
		game_manager.goto_scene('res://scenes/UI/sigmamenu.tscn')

func _on_loadingimage_pressed():
	$FileDialog.popup()


func _on_start_pressed():
	visible = false
	get_tree().change_scene_to_file("res://scenes/mainscene.tscn")
	pass # Replace with function body.


func _on_file_dialog_file_selected(path):
	var image = Image.new()
	image.load(path)
	#image_t = ImageTexture.new()
	#image_t.set_image(image)
	loadedscript.image = ImageTexture.new()
	loadedscript.image.set_image(image)
	$preview.texture = loadedscript.image
	$grass.disabled = false
	$snow.disabled = false
	$level.disabled = false
	$nonlinear.disabled = false


func _on_grass_pressed():
	game_manager.current_level = game_manager.levels["grass"]
	$grass.disabled = true
	$snow.disabled = false
	$level.disabled = false
	$nonlinear.disabled = false


func _on_snow_pressed():
	game_manager.current_level = game_manager.levels["snow"]
	$grass.disabled = false
	$snow.disabled = true
	$level.disabled = false
	$nonlinear.disabled = false

func _on_level_pressed():
	game_manager.current_level = game_manager.levels["level"]
	$grass.disabled = false
	$snow.disabled = false
	$level.disabled = true
	$nonlinear.disabled = false


func _on_nonlinear_pressed():
	#loadedscript.currentlevel = loadedscript.levels.level
	visible = false
	get_tree().change_scene_to_file("res://scenes/nonlinearlevel.tscn")
	pass # Replace with function body.
