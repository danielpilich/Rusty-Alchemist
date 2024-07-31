extends TileMap

@onready var timer = $Timer
@onready var flower_spawner = [
	$Flowers/Flower1,
	$Flowers/Flower2,
	$Flowers/Flower3,
	$Flowers/Flower4,
	$Flowers/Flower5,
	$Flowers/Flower6,
	$Flowers/Flower7,
	$Flowers/Flower8,
	$Flowers/Flower9,
	$Flowers/Flower10
]
@onready var enemy_spawner = $Enemy/Enemy1

const FLOWER = preload("res://scenes/environment/flower.tscn")
const SLIME = preload("res://scenes/entities/slime.tscn")

var enemy_instantiate = []
var flower_instantiate = []

func _ready():
	enemy_instantiate.resize(10)
	enemy_instantiate.fill(null)
	flower_instantiate.resize(10)
	flower_instantiate.fill(null)
	timer.autostart = true
	timer.start()
	generate_flowers()

func _on_timer_timeout():
	generate_enemies()
	await get_tree().create_timer(1).timeout
	generate_flowers()

func generate_flowers():
	var flower_counter = 0
	for i in 10:
		if flower_instantiate[i] == null:
			flower_instantiate[i] = FLOWER.instantiate()
			flower_instantiate[i].global_position = flower_spawner[flower_counter].global_position
			add_child(flower_instantiate[i])
		flower_counter += 1
		
func generate_enemies():
	for i in 10:
		await get_tree().create_timer(1).timeout
		if enemy_instantiate[i] == null:
			enemy_instantiate[i] = SLIME.instantiate()
			enemy_instantiate[i].add_to_group("Enemy")
			enemy_instantiate[i].global_position = enemy_spawner.global_position
			add_child(enemy_instantiate[i])
