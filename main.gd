extends Node

@onready var character := $Character as Character
@onready var game_ui := $CanvasLayer/GameUI as GameUI

func _ready() -> void:
	game_ui.init_character_inventory(character.inventory_data)


func _on_character_inventory_toggled() -> void:
	game_ui.toggle_character_inventory()
