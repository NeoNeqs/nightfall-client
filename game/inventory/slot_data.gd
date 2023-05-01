extends Resource
class_name SlotData

@export var item_data: ItemData
@export var quantity: int = 1:
	set = _set_quantity


func get_free_space() -> int:
	return item_data.stack_size - quantity

func can_be_stacked_with(other_slot_data: SlotData) -> bool:
	return item_data == other_slot_data.item_data and get_free_space() > 0

func transfer_quantity(other_slot_data: SlotData, amount: int) -> SlotData:
	var max_fill_quantity := get_free_space()
	
	var trasnfer_amount: int = min(other_slot_data.quantity, max_fill_quantity, amount)
	quantity += trasnfer_amount
	
	if other_slot_data.quantity - trasnfer_amount > 0:
		other_slot_data.quantity -= trasnfer_amount
		
		return other_slot_data
	return null

func take_one() -> int:
	var fill_quantity := 1
	quantity += fill_quantity
	
	return fill_quantity

func _set_quantity(new_quantity: int) -> void:
	if not item_data:
		Logger.error(Messages.SLOT_DATA_NO_ITEM_DATA % [self])
		return
	if new_quantity < 0:
		quantity = 0
		Logger.warning(Messages.SLOT_DATA_NO_QUANTITY % [
			new_quantity, item_data.id, quantity
		])
		return
	if new_quantity > item_data.stack_size:
		Logger.error(Messages.SLOT_DATA_STACK_SIZE_EXCEEDED % [item_data.stack_size, item_data.id])
		return
	quantity = new_quantity
