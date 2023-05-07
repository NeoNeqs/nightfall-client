extends Node

@onready var character := ($World as World).character as Character
@onready var game_ui := $CanvasLayer/GameUI as GameUI

func _ready() -> void:
	game_ui.initialize_character_inventory(character)

func _on_character_inventory_toggled() -> void:
	game_ui.toggle_character_inventory()
