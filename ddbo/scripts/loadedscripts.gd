extends Node

var image = null
var hp = 3
var isLinear = true
var score = 0

enum levels{
	grass,
	snow,
	level
}

var currentlevel = null

func _ready():
	currentlevel = levels.grass 

func _input(event):
	if event.is_action_pressed("T"):
		Engine.max_fps = 10
	elif event.is_action_released("T"):
		Engine.max_fps = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if hp <= 0:
		get_tree().change_scene_to_file("res://scenes/death_screen.tscn")
	pass
