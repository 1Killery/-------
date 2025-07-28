extends KinematicBody2D

enum {
	IDLE
	RUN,
	ATTACK,
	HIT,
	DEAD,
	
	
}

const speed = 150
const state = "IDLE"

onready var anim_sprait = $AnimatedSprite
onready var animp = $AnimationPlayer

var velocity = Vector2.ZERO
var health = 100

func _ready():
	anim_sprait.play("idle")

func _physics_process(delta):
	if health <= 0 :
		health = 0
		#state = DEAD
	
	match state:
		"RUN":
			run()
#		"ATTACK":
#			attack()
#		"HIT":
#			hit_state()
#		"DEAD":
#			dead()
#
	
	
	
	run()
	update_anim()

func update_anim() : 
	if velocity:
		anim_sprait.play("run")
	else:
		anim_sprait.play("idle")
		
	if velocity.x<0:
		anim_sprait.flip_h = true
		$CollisionShape2D.position.x = 2
	elif velocity.x>0:
		anim_sprait.flip_h = false
		$CollisionShape2D.position.x = -2

func run():
	velocity = Vector2.ZERO
	if Input.is_action_pressed("right"):
		velocity.x += speed
	if Input.is_action_pressed("left"):
		velocity.x-= speed
	if Input.is_action_pressed("down"):
		velocity.y+= speed
	if Input.is_action_pressed("up"):
		velocity.y -= speed
	velocity = velocity.normalized() * speed
	move_and_slide(velocity)
