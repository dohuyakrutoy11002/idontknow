extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	get_viewport().size = Vector2(720, 686)
	$AnimatedSprite2D.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
