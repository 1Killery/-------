extends KinematicBody2D

var velos = Vector2.ZERO
var speed = 150

func _process(delta):
	if Input.is_action_just_pressed("right"):
		velos.x = velos.normalized() * speed
	elif Input.is_action_just_pressed("left"):
		velos.x = velos.normalized() * speed
		
	else: 
		velos.x = 0
		
	move_and_slide(velos)
