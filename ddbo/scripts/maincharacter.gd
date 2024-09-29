extends CharacterBody2D

@onready var game_controller = get_owner()
var hp:int = 3:
	set(value):
		hp += value
		if hp <= 0:
			game_controller.goto_scene('res://scenes/death_screen.tscn')

var SPEED = 1000
var target_velocity = Vector2.ZERO
var flip
var firstInput : bool = false
var timeout = false


# Called when the node enters the scene tree for the first time.
func _ready():
	loadedscript.isLinear = false
	$AnimatedSprite2D.play()
	#var flip = $AnimatedSprite2D.scale.x * -1
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	movement(delta)
	if(firstInput): move_and_slide() 
	

func movement(delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if (direction != Vector2.ZERO): firstInput = true
	target_velocity = direction * SPEED
	
	if Input.is_action_pressed("ui_left"):
		$AnimatedSprite2D.scale.x = -0.1
		target_velocity.x += delta # 10 is the force
		target_velocity.y -= delta
	elif Input.is_action_pressed("ui_right"):
		$AnimatedSprite2D.scale.x = 0.1
		target_velocity.x -= delta # 10 is the force
		target_velocity.y += delta
	velocity = lerp(velocity, target_velocity, delta*10.0)
	if !loadedscript.isLinear:
		velocity.x -= lerp(SPEED, 0, 0.95)
		velocity.y += lerp(SPEED, 0, 0.95)
		#Added codes
		rotation_degrees = lerpf(rotation_degrees, 30 * direction.y, delta*10.0)


func _on_area_2d_area_entered(area):
	if area.is_in_group("skibidi"):
		if loadedscript.isLinear:
			get_tree().change_scene_to_file("res://scenes/mainscene.tscn")
		else:
			get_tree().change_scene_to_file("res://scenes/nonlinearlevel.tscn")
	elif area.is_in_group("scrimbloid"):
		pass
	else:
		if !timeout:
			loadedscript.hp -= 1
			$dildo.start()
	pass # Replace with function body.


func _on_dildo_timeout():
	timeout = true
	pass # Replace with function body.
