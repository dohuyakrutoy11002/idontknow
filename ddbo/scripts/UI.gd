extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#print(loadedscript.hp)
	#FPS count
	$Label.set_text("FPS" + str(Engine.get_frames_per_second()))
	
	#other ui elements
	match loadedscript.hp:
		3: $tylerdurden.play("first")
		2: $tylerdurden.play("second")
		1: $tylerdurden.play("thrid")
	pass
