extends Resource
class_name ActionData

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

#max_usage
@export var max_capacity: int = 1:
	set(new_max_capacity):
		if new_max_capacity < 1:
			new_max_capacity = 1
			Logger.warning(Messages.ITEM_DATA_INVALID_MAX_CAPACITY % [
				id, max_capacity, max_capacity
			])
		max_capacity = new_max_capacity


func use() -> int:
	Logger.error(Messages.NOT_IMPLEMENTED.format(get_stack()[-2]))
	return 0
