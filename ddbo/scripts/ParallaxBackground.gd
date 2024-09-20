extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	get_viewport().size = Vector2(1152, 648)
	if loadedscript.currentlevel == loadedscript.levels.grass:
		set_animation("grass")
	elif loadedscript.currentlevel == loadedscript.levels.snow:
		set_animation("snow")
	elif loadedscript.currentlevel == loadedscript.levels.level:
		set_animation("default")
	play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
