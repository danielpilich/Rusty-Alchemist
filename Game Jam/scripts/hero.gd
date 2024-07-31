extends CharacterBody2D

@onready var potion_marker = $PotionMarker
@onready var animated_sprite = $AnimatedSprite2D
@onready var equipment_label = %EquipmentLabel
@onready var jump = $Jump
@onready var throw = $Throw
@onready var alchemy = $Alchemy
@onready var pick_up = $PickUp

var speed = 130.0
const JUMP_VELOCITY = -270.0
var fire_direction = true
var ingredients = 0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var potion_equipped = false
var potion_cooldown = true
var potion = preload("res://scenes/environment/potion.tscn")
var potion_amount = 3

func _ready():
	equipment_label.text = "Flowers: " + str(ingredients) + "\nPotions: " + str(potion_amount)

func _physics_process(delta):
	
	var direction = Input.get_axis("left", "right")
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump.play()
	
	#Flip the Sprite
	if potion_equipped:
		speed = 50.0
		if direction > 0:
			fire_direction = true
			animated_sprite.flip_h = false
		elif direction < 0:
			fire_direction = false
			animated_sprite.flip_h = true
	if !potion_equipped:
		speed = 130.0
		if direction > 0:
			fire_direction = true
			animated_sprite.flip_h = false
		elif direction < 0:
			fire_direction = false
			animated_sprite.flip_h = true
			
	# Play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	
	if Input.is_action_just_pressed("equip_potion"):
		if potion_equipped:
			potion_equipped = false
		else:
			potion_equipped = true
	
	if Input.is_action_just_pressed("attack") and potion_equipped and potion_cooldown and potion_amount != 0:
		potion_cooldown = false
		potion_amount -= 1		
		equipment_label.text = "Flowers: " + str(ingredients) + "\nPotions: " + str(potion_amount)
		var potion_instance = potion.instantiate()
		potion_instance.direction = fire_direction
		potion_instance.global_position = potion_marker.global_position		
		throw.play()
		add_child(potion_instance)
		
		await get_tree().create_timer(0.4).timeout
		potion_cooldown= true

func add_ingredient():
	pick_up.play()
	ingredients += 1
	equipment_label.text = "Flowers: " + str(ingredients) + "\nPotions: " + str(potion_amount)

func make_potion():
	if ingredients != 0:
		alchemy.play()
		ingredients -= 1
		potion_amount += 1
		equipment_label.text = "Flowers: " + str(ingredients) + "\nPotions: " + str(potion_amount)
