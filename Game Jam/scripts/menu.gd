extends Control




func _on_keybinds_pressed():
	get_tree().change_scene_to_file("res://scenes/settings.tscn")


func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/select_level.tscn")
	
	
func _on_quit_pressed():
	get_tree().quit()
