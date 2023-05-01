extends Resource
class_name ItemData

@export var display_name: String = "":
	set(new_display_name):
		display_name = new_display_name.c_escape()

@export var id: String = "":
	set(new_id):
		if Utils.is_valid_item_id(new_id):
			id = new_id
			return
		Logger.error(Messages.ITEM_DATA_INVALID_ID_FORMAT % [new_id])

@export var icon: Texture2D = null

@export var stack_size: int = 1:
	set(new_stack_size):
		if new_stack_size < 1:
			new_stack_size = 1
			Logger.warning(Messages.ITEM_DATA_INVALID_STACK_SIZE % [
				id, stack_size, stack_size
			])
		stack_size = new_stack_size
