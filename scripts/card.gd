extends PanelContainer

@export var card_title: String 
@export var card_description: String 
@export var card_icon: Texture

# References to UI elements
@onready var title_label = $MarginContainer/VBoxContainer/Label
@onready var icon_texture_rect = $MarginContainer/VBoxContainer/TextureRect
@onready var vbox = $MarginContainer/VBoxContainer
var select_skill: Button = null  # Declare the button outside to keep track of it

signal skill_pressed(value: String)
func _ready():
	update_card()

func update_card():
	
	title_label.text = card_title
	if card_icon:
		icon_texture_rect.texture = card_icon
	if select_skill == null and (card_title != null and card_title != ""):
		select_skill = Button.new()
		select_skill.text = "SELECT"
		select_skill.connect("pressed", Callable(self, "on_pressed").bind(card_title))
		vbox.add_child(select_skill)
	
func on_pressed(value):
	SavedSkills.add_to_skill(value)
	emit_signal("skill_pressed",value)
