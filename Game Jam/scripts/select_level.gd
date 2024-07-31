extends Control

const Game = preload("res://scripts/game.gd")

func _on_dirt_pressed():
	Game.change_map(0)
	get_tree().change_scene_to_file("res://scenes/levels/game_dirt.tscn")



func _on_sand_pressed():
	Game.change_map(1)
	get_tree().change_scene_to_file("res://scenes/levels/game_sand.tscn")




func _on_back_to_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
