extends AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match loadedscript.levels:
		loadedscript.levels.grass:
			stream = load("res://assets/music(finnaly)/level music/grassy.wav")
			play()
			print("h")
		loadedscript.levels.snow:
			stream = load("res://assets/music(finnaly)/level music/frozen_over.wav")
			play()
		loadedscript.levels.level:
			stream = load("res://assets/music(finnaly)/level music/stars_above.wav")
			play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match loadedscript.levels:
		loadedscript.levels.grass:
			stream = load("res://assets/music(finnaly)/level music/grassy.wav")
			play()
		loadedscript.levels.snow:
			stream = load("res://assets/music(finnaly)/level music/frozen_over.wav")
			play()
		loadedscript.levels.level:
			stream = load("res://assets/music(finnaly)/level music/stars_above.wav")
			play()
	pass
