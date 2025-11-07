extends CanvasLayer



func _on_playagain_pressed() -> void:
	get_tree().change_scene_to_file("res://platformer_tp3/assets/scenes/areas/area_1.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
