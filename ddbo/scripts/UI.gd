extends Control

@onready var player: CharacterBody2D = $'../CharacterBody2D'

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#print(loadedscript.hp)
	#FPS count
	$Label.set_text("FPS" + str(Engine.get_frames_per_second()))



func _on_character_body_2d_hp_changed(hp: Variant) -> void:
	print(hp)
	match hp:
		3: $tylerdurden.play("first")
		2: $tylerdurden.play("second")
		1: $tylerdurden.play("thrid")
