extends KinematicBody2D

var speed = 150

func _process(delta):
	var move = move()
	var direction = move.normalized()
	
	

func _ready():
	pass

func move():
	var move_x = Input.get_action_strength("right") - Input.get_action_strength("left")
	var move_y = Input.get_action_strength("down") - Input.get_action_strength("up")
	return Vector2(move_x,move_y)
