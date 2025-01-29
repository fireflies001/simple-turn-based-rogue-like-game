extends Control


const CARD_SCENE = preload("res://card.tscn")
@onready var hbox = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer
const JSON_FILE_PATH: String = "res://scripts/skills.json"
# Called when the node enters the scene tree for the first time.
func _ready():
	var json_data = FileAccess.open(JSON_FILE_PATH, FileAccess.READ)
	var data = JSON.parse_string(json_data.get_as_text())
	for skill in data:
		var card = CARD_SCENE.instantiate()
		hbox.add_child(card)
		card.card_title = skill["name"]
		card.card_description = skill["desc"]
		card.card_icon = load("res://icons/" + skill["icon"])
		card.update_card()
		

func _on_button_pressed():
	get_tree().change_scene_to_file("res://world.tscn")
