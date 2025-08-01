extends KinematicBody2D

enum {
	RUN,
	ATTACK,
	DOUBLE_ATTACK,
	HIT,
	BLOCK
	
	
}

const speed = 150


onready var anim_sprait = $AnimatedSprite
onready var animp = $AnimationPlayer

var velocity = Vector2.ZERO
var health = 100
var state = "RUN"

func _ready():
	anim_sprait.play("idle")

# warning-ignore:unused_argument
func _physics_process(delta):
	match state:
		"RUN":
			run()
#		"ATTACK":
#			attack()
#		"HIT":
#			hit_state()
		"BLOCK":
			block()
	
	
	if health <= 0 :
		health = 0
		animp.play("dead")
		yield(animp, "animation_finished")
	
	update_anim()

func update_anim() : 
	if velocity:
		animp.play("run")
	else:
		animp.play("idle")
		
	if velocity.x<0:
		anim_sprait.flip_h = true
		$CollisionShape2D.position.x = 2
	elif velocity.x>0:
		anim_sprait.flip_h = false
		$CollisionShape2D.position.x = -2
	move_and_slide(velocity)
	
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
	
	if Input.is_action_pressed("block"):
		state = BLOCK
# warning-ignore:return_value_discarded

func block():
	animp.play("block")
	yield(animp, "animation_finished")
	state = RUN
	
