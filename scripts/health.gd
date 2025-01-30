class_name HEALTH extends Node2D

@export var health_points: float
var actual_health_points: float

func set_health():
	actual_health_points = health_points

func get_health():
	return actual_health_points
	
func regenerate_health(health:float, multiplier: float):
	if(health < actual_health_points):
		health *= multiplier
	return health

func damage_taken(curHealth, value, sprite, curposition, skill):
	var damage: Dictionary
	damage = await skill_effect(curHealth, sprite, skill,curposition)
	if damage["effect_class"] == "DAMAGE":
		curHealth -= damage["total_damage"]
		return curHealth 
	else:
		curHealth += damage["total_healing"]
		return curHealth 

func sprite_flash(sprite):
	var tween: Tween = create_tween()
	tween.tween_property(sprite, "modulate:v", 1, 0.25).from(15)

func skill_effect(current_health, sprite, skill, curposition) -> Dictionary:
	var damage_dict = {
		"effect_class": "",
		"total_damage": 0,
		"total_healing": 0
	}
	if skill["status_effect"] == "DEBUFF":
		if skill["kind_of_status"] == "DOT":
			damage_dict["effect_class"] = "DAMAGE"
			damage_dict["total_damage"] = skill["damage"] + skill["status_dmg"]
			DamageNumber.display_damage(skill["damage"], curposition)
			sprite_flash(sprite)
			await get_tree().create_timer(1).timeout
			DamageNumber.display_damage(skill["status_dmg"], curposition)
			sprite_flash(sprite)
		return damage_dict
	else:
		if skill["kind_of_status"] == "HEALING":
			damage_dict["effect_class"] = "DAMAGE"
			damage_dict["total_healing"] = skill["status_buff"]
		return damage_dict
