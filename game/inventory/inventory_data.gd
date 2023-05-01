extends Resource
class_name InventoryData

signal updated(inventory_data: InventoryData)
signal interacted(inventory_data: InventoryData, index: int, buttton_index: int)

const MIN_COLUMNS := 1
const MAX_COLUMNS := 9

@export_range(MIN_COLUMNS, MAX_COLUMNS, 1)
var columns: int = 9

@export
var display_name: String

@export
var slot_data: Array[SlotData] = []

func on_slot_clicked(index: int, button_index: int) -> void:
	interacted.emit(self, index, button_index)

func slot_pop(index: int) -> SlotData:
	var slot := slot_data[index]

	if slot:
		slot_data[index] = null
		updated.emit(self)
	return slot

func slot_pull_half(index: int) -> SlotData:
	var slot := slot_data[index]
	
	if not slot:
		return null
	
	var return_slot: SlotData
	if slot.quantity > 1:
		slot_data[index] = slot.duplicate()
		slot_data[index].quantity = 0
		return_slot = slot_data[index].transfer_quantity(slot, int(slot.quantity / 2.0))
	else:
		slot_data[index] = null
		return_slot = slot
	
	updated.emit(self)
	return return_slot

func slot_pull(index: int, grabbed_slot_data: SlotData, amount: int) -> SlotData:
	var slot := slot_data[index]

	var return_slot: SlotData
	if slot:
		if slot.can_be_stacked_with(grabbed_slot_data):
			return_slot = slot.transfer_quantity(grabbed_slot_data, amount)
		else:
			# Items can't stack, swap them instead
			slot_data[index] = grabbed_slot_data
			return_slot = slot
	else:
		slot_data[index] = grabbed_slot_data.duplicate()
		slot_data[index].quantity = 0
		return_slot = slot_data[index].transfer_quantity(grabbed_slot_data, amount)

	updated.emit(self)
	return return_slot

func slot_pull_max(index: int, grabbed_slot_data: SlotData) -> SlotData:
	return slot_pull(index, grabbed_slot_data, grabbed_slot_data.quantity)
