extends Control
class_name GameUI

@onready var drag_slot := $DragSlot as DragSlot

@onready var hotbar := $Hotbar as VBoxContainer
@onready var inventory_window := $InventoryWindow as InventoryWindow

func initialize_character_inventory(character: Character) -> void:
	# TODO: this mess...
	var inventories := [character.inventory_data, character.hotbar_data]
	
	var update_all := func(inventory_data: InventoryData):
		inventory_window.update(character.inventory_data)
		hotbar.update(character.hotbar_data)
	
	for inv in inventories:
		inv.item_clicked.connect(_on_inventory_item_clicked)
		inv.updated.connect(update_all)
		
		update_all.call(null)
	
#	character.inventory_data.item_clicked.connect(_on_inventory_item_clicked)
#	character.inventory_data.updated.connect(
#		func(inventory_data: InventoryData):
#			inventory_window.update(inventory_data)
#			hotbar.update(character.hotbar_data)
#	)
#
#	character.hotbar_data.item_clicked.connect(_on_inventory_item_clicked)
#	character.hotbar_data.updated.connect(
#		func(hotbar_data: InventoryData):
#			hotbar.update(hotbar_data)
#			inventory_window.update(character.inventory_data)
#	)
#
#	inventory_window.update(character.inventory_data)
#	hotbar.update(character.hotbar_data)

func _on_inventory_item_clicked(inventory_data: InventoryData, 
		index: int, buttton_index: int) -> void:
	
	match [drag_slot.source_item, buttton_index]:
		[null, MOUSE_BUTTON_LEFT]: # Pick up all items from the slot
			drag_slot.source_inventory_data = inventory_data
			drag_slot.source_item = inventory_data.get_item(index)
			drag_slot.source_index = index
		[_, MOUSE_BUTTON_LEFT]:
			if drag_slot.source_inventory_data == inventory_data:
				inventory_data.move_item(drag_slot.source_index, index)
			else:
				if drag_slot.source_inventory_data.persistent:
					inventory_data.set_item(index, drag_slot.source_item)
			
			drag_slot.source_inventory_data = null
			drag_slot.source_item = null
			drag_slot.source_index = -1
		[null, MOUSE_BUTTON_RIGHT]:
			inventory_data.item_use(index)
	drag_slot.update()

func toggle_character_inventory() -> void:
	inventory_window.visible = not inventory_window.visible
