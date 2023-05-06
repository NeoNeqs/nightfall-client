extends Control
class_name GameUI

var grabbed_item: Item

@onready var inventory = $Inventory as Inventory
@onready var grabbed_slot = $GrabbedSlot as InventorySlot

func initialize_character_inventory(inventory_data: InventoryData) -> void:
	inventory_data.interacted.connect(on_inventory_interacted)
	inventory_data.updated.connect(inventory.update)
	
	inventory.update(inventory_data)

func _physics_process(_delta: float) -> void:
	if grabbed_slot.visible:
		_grabbed_slot_follow_mouse()

func toggle_character_inventory() -> void:
	inventory.visible = not inventory.visible

func on_inventory_interacted(inventory_data: InventoryData, index: int, 
		buttton_index: int) -> void:
	
	# Inventory interaction state
	match [grabbed_item, buttton_index]:
		[null, MOUSE_BUTTON_LEFT]: # Pick up items
			grabbed_item = inventory_data.item_pop(index)
		[_, MOUSE_BUTTON_LEFT]: # Stack items
			grabbed_item = inventory_data.item_pull_max(
				index, 
				grabbed_item
			)
		# This needs to trigger `use` function on an item insteaf of picking item
		# Change pick up 1 item to shift right click / middle click ?
		# Pick up 1 item
		[null, MOUSE_BUTTON_RIGHT]:
			#grabbed_item_stack = inventory_data.slot_pull_half(index)
			inventory_data.item_use(index)
		[_, MOUSE_BUTTON_RIGHT]: # Place 1 item
			grabbed_item = inventory_data.item_pull(
				index, 
				grabbed_item, 
				1
			)
	
	_update_grabbed_slot()

func _update_grabbed_slot() -> void:
	if grabbed_item:
		grabbed_slot.show()
		grabbed_slot.set_item(grabbed_item)
		return
	
	grabbed_slot.hide()

func _grabbed_slot_follow_mouse():
	var upper_bound: Vector2 = Vector2(get_tree().root.size) - grabbed_slot.size
	
	grabbed_slot.global_position = get_global_mouse_position() + Vector2(5, 5)
	grabbed_slot.global_position.x = clamp(grabbed_slot.global_position.x, 0, upper_bound.x)
	grabbed_slot.global_position.y = clamp(grabbed_slot.global_position.y, 0, upper_bound.y)
