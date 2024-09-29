extends Node2D

@onready var game_music: AudioStreamPlayer2D = $GameMusic
@onready var scene_controller: Node = $SceneController

var current_scene = null


func _ready():
	current_scene = scene_controller.get_child(scene_controller.get_child_count() - 1)


func goto_scene(path):
	call_deferred("_deferred_goto_scene", path)


func _deferred_goto_scene(path):
	current_scene.free()
	var new_scene = ResourceLoader.load(path)

	current_scene = new_scene.instantiate()
	scene_controller.add_child(current_scene)

#Loads new track
func change_music_track(_path) -> void:
	#TODO: Need to finish music loading
	pass


#Fades music track
func _fade_music_track() -> void:
	pass
