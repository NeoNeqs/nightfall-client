extends Resource
class_name Item

@export var id: String = "":
	set = _set_id

@export var display_name: String = ""

@export var icon: Texture2D = null

@export var max_usage: int = 1:
	set = _set_max_usage

@export var quantity: int = 1:
	set = _set_quantity



func use():
	pass

func get_available_space() -> int:
	return max_usage - quantity

func can_be_stacked_with(other_item: Item) -> bool:
	return id == other_item.id and get_available_space() > 0

func stack(other_item: Item, amount: int) -> Item:
	var max_fill_quantity := get_available_space()
	
	var fill_amount: int = min(other_item.quantity, max_fill_quantity, amount)
	quantity += fill_amount
	
	if other_item.quantity - fill_amount > 0:
		other_item.quantity -= fill_amount
		
		# There's still some left of that item
		return other_item
	
	# Took all of that item
	return null

func _set_id(new_id) -> void:
	if not Utils.is_valid_item_id(new_id):
		Logger.error(Messages.ITEM_DATA_INVALID_ID_FORMAT % [new_id])
		
	id = new_id

func _set_quantity(new_quantity: int) -> void:
	if new_quantity > max_usage:
		Logger.error(Messages.SLOT_DATA_MAX_CAPACITY_EXCEEDED % [max_usage, id])
		return
	
	quantity = new_quantity

func _set_max_usage(new_max_usage: int) -> void:
	if new_max_usage < 1:
		new_max_usage = 1
		Logger.warning(Messages.ITEM_DATA_INVALID_MAX_CAPACITY % [
			id, max_usage, max_usage
		])
	max_usage = new_max_usage
