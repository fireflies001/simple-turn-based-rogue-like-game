extends Control

@onready var popup = $popup_skill
@onready var skillContainer = $skillContainer/MarginContainer/VBoxContainer/HBoxContainer
@onready var healthbar = $skillContainer/MarginContainer/VBoxContainer/HBoxContainer2/TextureProgressBar
@export var healthNode: HEALTH
@onready var player = $player
@onready var damagepos = $damage_pos
@onready var textContainer = $textContainer
@onready var textAnimation = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
signal attack_enemy(value: String)
signal popup_skill()

func _on_popup_skill_added_skill(value):
	for child in skillContainer.get_children():
		child.queue_free()
	popup.visible = false
	var skill = Button.new()
	skill.text = value["name"]
	skill.connect("pressed", Callable(self, "skill_pressed").bind(value))
	skillContainer.add_child(skill)

func skill_pressed(skill):
	
	emit_signal("attack_enemy",skill)

func _on_enemy_1_attack_player(value):
	var Enemy_turn_text = Label.new()
	Enemy_turn_text.text = "ENEMY TURN"
	textContainer.add_child(Enemy_turn_text)
	textAnimation.play("skill_dialog")
	await get_tree().create_timer(2).timeout
	textAnimation.play("skill_dialog_out")
	await get_tree().create_timer(2).timeout
	Enemy_turn_text.queue_free()
	await get_tree().create_timer(1).timeout
	healthbar.value = await healthNode.damage_taken(healthbar.value,10,player.get_node("AnimatedSprite2D"), damagepos.global_position, value)
	emit_signal("popup_skill")
