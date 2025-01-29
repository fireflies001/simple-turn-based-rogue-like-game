extends Node

var chosen_skill: Array = []


func add_to_skill(value):
	chosen_skill.append(value)
	
	
func remove_skill(index):
	if index >= 0 and index < chosen_skill.size():
		chosen_skill.remove_at(index)
