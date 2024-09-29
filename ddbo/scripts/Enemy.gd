extends CharacterBody2D

func _ready():
	$AnimatedSprite2D.play("plant1")

func _on_area_2d_area_entered(_area):
	loadedscript.score += 100
	queue_free()
	pass # Replace with function body.
