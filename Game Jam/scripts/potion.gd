extends RigidBody2D

var speed = 300
var direction = true

var gravity_potion = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	set_as_top_level(true)
	contact_monitor = true
	max_contacts_reported = 1
	if direction:
		apply_central_impulse(Vector2(200, -200))
	elif !direction:
		apply_central_impulse(Vector2(-200, -200))

func _process(delta):
	pass

func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()

func _on_body_entered(body):
	if body.is_in_group("Enemy"):
		body.death()
	queue_free()
