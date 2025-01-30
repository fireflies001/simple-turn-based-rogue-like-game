extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@export var healthNode: HEALTH
@onready var sprite = $AnimatedSprite2D
@onready var healthbar = $PanelContainer/MarginContainer/VBoxContainer/ProgressBar
@onready var damagepos = $damage_pos
const JSON_FILE_PATH: String = "res://scripts/skills.json"
signal attack_player(value)

func _on_world_attack_enemy(value):
	healthbar.value = await healthNode.damage_taken(healthbar.value,10,sprite, damagepos.global_position,value)
	await get_tree().create_timer(1).timeout
	var json_data = FileAccess.open(JSON_FILE_PATH, FileAccess.READ)
	var data = JSON.parse_string(json_data.get_as_text())
	var i = randi_range(0,data.size()-1)
	emit_signal("attack_player",data[i])
