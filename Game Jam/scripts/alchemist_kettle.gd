extends Area2D

@onready var hero = %Hero
@onready var destroyed = $Destroyed
@onready var timer = %Timer
@onready var game = $".."

const MAX_HEALTH = 5
var health = MAX_HEALTH
var hero_state = 0

func _ready():
	$HealthBar.max_value = MAX_HEALTH
	set_health_bar()

func set_health_bar():
	$HealthBar.value = health

func _process(delta):
	if Input.is_action_just_pressed("make_potion") and hero_state:
		hero.make_potion()
	if health == 0:
		game.reset()
		queue_free()

func _on_body_entered(body):
	if body.name == "Hero":
		hero_state = 1
	if body.is_in_group("Enemy"):
		health-=1
		body.is_dead = 1
	set_health_bar()

func _on_body_exited(body):
	if body.name == "Hero":
		hero_state = 0
