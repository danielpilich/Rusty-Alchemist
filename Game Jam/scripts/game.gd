extends Node2D

const DIRT_MAP = preload("res://scenes/maps/dirt_map.tscn")
const SAND_MAP = preload("res://scenes/maps/sand_map.tscn")

@onready var timer = %Timer
@onready var day_night = $Day_night

static var variant = 0
var time = 0
var maps = [DIRT_MAP,SAND_MAP]
var map_instance

func _ready():
	map_instance = maps[variant].instantiate()
	add_child(map_instance)	
	
func reset():
	Engine.time_scale = 0.5
	day_night.game_end = true
	timer.start()

func _on_timer_timeout():
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()

func _on_exit_pressed():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

static func change_map(number):
	variant = number
