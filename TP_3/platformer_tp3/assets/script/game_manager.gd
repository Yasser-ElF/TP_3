extends Node

var current_area = 1
var area_path = "res://platformer_tp3/assets/scenes/areas/"
var energy_cells = 0

func next_level():
	current_area += 1
	var full_path = area_path + "area_" + str(current_area) + ".tscn"
	get_tree().change_scene_to_file(full_path)
	print("The player has moved to area " + str(current_area))
	set_up_area()

func set_up_area():
	reset_energy_cells()

func add_energy_cell():
	energy_cells += 1
	
	if energy_cells >= 10:
		if current_area == 3:

			get_tree().change_scene_to_file("res://platformer_tp3/assets/scenes/gameover.tscn")
		else:
			var portal = get_tree().get_first_node_in_group("area_exits") as AreaExit
			portal.open()

func reset_energy_cells():
	energy_cells = 0
