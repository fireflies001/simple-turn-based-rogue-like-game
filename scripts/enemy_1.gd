extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@export var healthNode: HEALTH
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var sprite = $AnimatedSprite2D
@onready var healthbar = $PanelContainer/MarginContainer/VBoxContainer/ProgressBar
@onready var damagepos = $damage_pos
func _physics_process(delta):
	
	if Input.is_action_just_pressed("attack"):
		healthNode.damage_taken(healthbar.value,10,sprite, damagepos.global_position)

