extends Control


const CARD_SCENE = preload("res://scenes/card.tscn")
@onready var hbox = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer
const JSON_FILE_PATH: String = "res://scripts/skills.json"
# Called when the node enters the scene tree for the first time.

signal added_skill(value: String)
func _ready():
	load_cards()

func test_signal(value):
	emit_signal("added_skill",value)
	
	
func load_cards():
	var json_data = FileAccess.open(JSON_FILE_PATH, FileAccess.READ)
	var data = JSON.parse_string(json_data.get_as_text())
	
	for n in range(3):
		var i = randi_range(0,data.size()-1)
		var card = CARD_SCENE.instantiate()
		hbox.add_child(card)
		card.card_title = data[i]["name"]
		card.card_description = data[i]["desc"]
		card.card_icon = load("res://icons/" + data[i]["icon"])
		card.get_skill_effect(data[i])
		card.update_card()
		card.skill_pressed.connect(Callable(self,"test_signal"))


func _on_world_popup_skill():
	for child in hbox.get_children():
		child.queue_free()
	load_cards()
	await get_tree().create_timer(2).timeout
	visible = true
