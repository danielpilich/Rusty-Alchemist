extends Node2D

const DIRT_MAP = preload("res://scenes/maps/dirt_map.tscn")
#const SNOW_MAP = preload("res://scenes/maps/snow_map.tscn")
#const SAND_MAP = preload("res://scenes/maps/sand_map.tscn")
@onready var timer = %Timer
@onready var timer_enemy = $Timer_enemy
@onready var flower_1 = $Flowers/Flower1
@onready var enemy_1 = $Enemy/Enemy1

const FLOWER = preload("res://scenes/environment/flower.tscn")
const SLIME = preload("res://scenes/entities/slime.tscn")

@onready var day_night = $Day_night
var time = 0

var enemy_instantiate = null
var flower_instantiate = null
var maps = [DIRT_MAP]
var map_instance

func _ready():
	map_instance = maps[0].instantiate()
	add_child(map_instance)	

func _process(delta):
	pass
	#if Input.is_action_just_pressed("change_map"):
		#map_instance.queue_free()
		#map_instance = maps[randi()%3].instantiate()
		#add_child(map_instance)
	
func reset():
	Engine.time_scale = 0.5
	day_night.game_end = true
	timer.start()

func _on_timer_timeout():
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()

func _on_timer_enemy_timeout():
	if flower_instantiate == null:
		self.flower_instantiate = FLOWER.instantiate()
		flower_instantiate.global_position = flower_1.global_position
		add_child(flower_instantiate)
	if enemy_instantiate == null:
		self.enemy_instantiate = SLIME.instantiate()
		enemy_instantiate.global_position = enemy_1.global_position
		add_child(enemy_instantiate)
