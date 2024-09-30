extends Node2D
@onready var game_music: AudioStreamPlayer = $GameMusic

@onready var scene_controller: Node = $SceneController

var image = null
var isLinear = true

var tracks:Dictionary = {
	"title_screen" = preload('res://assets/music(finnaly)/Swazz Loop 1 (Title Screen).wav'),
	"grass_level" = preload('res://assets/music(finnaly)/level music/grassy.wav'),
	"snow_level" = preload('res://assets/music(finnaly)/level music/frozen_over.wav'),
	"level" = preload('res://assets/music(finnaly)/level music/stars_above.wav')
}

const levels: Dictionary = {
	"grass": {
		"track_name":"grass_level",
		"level_background":"grass",
	},
	"snow":{
		"track_name":"snow_level",
		"level_background":"snow",
	},
	"level":{
		"track_name":"level",
		"level_background":"level"
	},
}

var current_level = levels["grass"] 


var current_track:String = ""
var initial_scene:PackedScene = preload('res://scenes/UI/sigmamenu.tscn')
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
func change_music_track(track_name:String) -> void:
	current_track = track_name
	game_music.stream = tracks[current_track]
	game_music.play()


#Fades music track
func _fade_music_track() -> void:
	pass
