extends Resource
class_name InventoryData

signal updated(inventory_data: InventoryData)
signal interacted(inventory_data: InventoryData, index: int, buttton_index: int)

@export var columns: int = 9
@export var display_name: String
@export var items: Array[Item] = []
@export var item_blacklist: Array[Script] = []

func add_item(p_item: Item) -> void:
	if _is_item_blacklisted(p_item):
		return
	
	var index := items.find(null)
	# return error ERR_FULL ?
	if index == -1:
		return
	
	items[index] = p_item
	
	updated.emit(self)

func set_item(index: int, p_item: Item) -> void:
	items[index] = p_item

func on_item_clicked(index: int, button_index: int) -> void:
	interacted.emit(self, index, button_index)

func item_pop(index: int) -> Item:
	var item := items[index]
	
	if item:
		items[index] = null
		updated.emit(self)
	
	return item

#func item_pull_half(index: int) -> Item:
#	var item := items[index]
#
#	if not item:
#		return null
#
#	var return_item: Item
#	if item.quantity > 1:
#		items[index] = item.duplicate()
#		items[index].quantity = 0
#		return_item = items[index].stack(item, int(item.quantity / 2.0))
#	else:
#		items[index] = null
#		return_item = item
#
#	updated.emit(self)
#	return return_item

func item_pull(index: int, grabbed_item: Item, quantity: int) -> Item:
	var item := items[index]
	
	var return_item: Item
	if not item:
		items[index] = grabbed_item.duplicate()
		items[index].quantity = 0
		return_item = items[index].stack(grabbed_item, quantity)
		updated.emit(self)
		return return_item
	
	if item.can_be_stacked_with(grabbed_item):
		return_item = item.stack(grabbed_item, quantity)
	else:
		# Items can't stack, swap them instead
		items[index] = grabbed_item
		return_item = item
	
	updated.emit(self)
	return return_item

func item_pull_max(index: int, grabbed_item: Item) -> Item:
	return item_pull(index, grabbed_item, grabbed_item.quantity)

func item_use(index: int) -> void:
	var item := items[index]
	
	if not item:
		return
	
	item.quantity -= item.use()
	if item.quantity < 1:
		items[index] = null
	updated.emit(self)

func _is_item_blacklisted(p_item: Item) -> bool:
	return item_blacklist.any(func(type): return is_instance_of(p_item, type))
