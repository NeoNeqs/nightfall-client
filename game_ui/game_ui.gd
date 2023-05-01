extends Control
class_name GameUI

var grabbed_slot_data: SlotData

@onready var inventory = $Inventory as Inventory
@onready var grabbed_slot = $GrabbedSlot as InventorySlot


func _physics_process(_delta: float) -> void:
	if not grabbed_slot.visible:
		return
	
	var upper_bound: Vector2 = Vector2(get_tree().root.size) - grabbed_slot.size
	
	grabbed_slot.global_position = get_global_mouse_position() + Vector2(5, 5)
	grabbed_slot.global_position.x = clamp(grabbed_slot.global_position.x, 0, upper_bound.x)
	grabbed_slot.global_position.y = clamp(grabbed_slot.global_position.y, 0, upper_bound.y)

func init_character_inventory(inventory_data: InventoryData) -> void:
	inventory_data.interacted.connect(on_inventory_interacted)
	inventory_data.updated.connect(inventory.fill_item_grid)
	inventory.fill_item_grid(inventory_data)

func toggle_character_inventory() -> void:
	inventory.visible = not inventory.visible

func on_inventory_interacted(inventory_data: InventoryData, index: int, 
		buttton_index: int) -> void:
	
	# Inventory interaction state
	match [grabbed_slot_data, buttton_index]:
		# Pick up items
		[null, MOUSE_BUTTON_LEFT]:
			grabbed_slot_data = inventory_data.slot_pop(index)
		# Stack items
		[_, MOUSE_BUTTON_LEFT]:
			grabbed_slot_data = inventory_data.slot_pull_max(
				index, 
				grabbed_slot_data
			)
		# Pick up 1 item
		[null, MOUSE_BUTTON_RIGHT]:
			grabbed_slot_data = inventory_data.slot_pull_half(index)
		# Place 1 item
		[_, MOUSE_BUTTON_RIGHT]:
			grabbed_slot_data = inventory_data.slot_pull(
				index, 
				grabbed_slot_data, 
				1
			)
	
	_update_grabbed_slot()

func _update_grabbed_slot() -> void:
	if grabbed_slot_data:
		grabbed_slot.show()
		grabbed_slot.set_data(grabbed_slot_data)
	else:
		grabbed_slot.hide()

