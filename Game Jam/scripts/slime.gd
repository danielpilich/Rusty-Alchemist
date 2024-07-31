extends CharacterBody2D

var is_dead = 0
const SPEED = 30.0
const JUMP_VELOCITY = -200.0
var direction = -1
var sound_played = false
@onready var ray_cast_2d = $RayCast2D
@onready var animated_sprite = $AnimatedSprite2D
@onready var timer = $Timer
@onready var enemy_jump_sound = $EnemyJumpSound
@onready var hit = $Hit

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if ray_cast_2d.is_colliding() and is_on_floor():
		velocity.y = JUMP_VELOCITY
		enemy_jump_sound.play()
		
	# Play animations
	if is_dead:
		if !sound_played:
			hit.play()
			sound_played = true
		direction = 0
		velocity.x = 0
		get_node("CollisionShape2D").disabled = true
		animated_sprite.play("death")
		await animated_sprite.animation_finished
		queue_free()
	else:
		if is_on_floor():
			animated_sprite.play("run")
		else:
			animated_sprite.play("jump")
	
	if direction:
			velocity.x = direction * SPEED

	move_and_slide()

func death():
	hit.pitch_scale = 3
	is_dead = true
