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

func damage_taken(curHealth, value, sprite, curposition):
	curHealth -= value
	DamageNumber.display_damage(value, curposition)
	sprite_flash(sprite)
	return curHealth

func sprite_flash(sprite):
	var tween: Tween = create_tween()
	tween.tween_property(sprite, "modulate:v", 1, 0.25).from(15)
