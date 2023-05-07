extends Resource
class_name InventoryData

signal updated(inventory_data: InventoryData)
signal item_clicked(inventory_data: InventoryData, index: int, buttton_index: int)

@export var columns: int = 9
@export var display_name: String
@export var items: Array[Item] = []
@export var item_blacklist: Array[Script] = []
@export var persistent: bool = true

func add_item(p_item: Item) -> bool:
	if _is_item_blacklisted(p_item):
		return false
	
	var index := items.find(null)
	if index == -1:
		return false
	
	items[index] = p_item
	updated.emit(self)
	
	return true

func move_item(from_index: int, to_index: int) -> bool:
	if from_index >= items.size():
		Logger.error("from_index out of bounds")
		return false
	
	if to_index >= items.size():
		Logger.error("to_index out of bounds")
		return false
	
	var item := items[from_index]
	
	items[from_index] = null
	items[to_index] = item
	updated.emit(self)
	
	return true

func set_item(index: int, p_item: Item, force := false) -> bool:
	if index >= items.size():
		Logger.error("index out of bounds")
		return false
	
	if _is_item_blacklisted(p_item):
		return false
	
	if items[index] == null or force:
		items[index] = p_item
		updated.emit(self)
		
		return true
	return false

func get_item(index: int) -> Item:
	return items[index]

func on_item_clicked(index: int, button_index: int) -> void:
	item_clicked.emit(self, index, button_index)

#func item_pop(index: int) -> Item:
#	var item := items[index]
#
#	if item:
#		items[index] = null
#		updated.emit(self)
#
#	return item
#
##func item_pull_half(index: int) -> Item:
##	var item := items[index]
##
##	if not item:
##		return null
##
##	var return_item: Item
##	if item.quantity > 1:
##		items[index] = item.duplicate()
##		items[index].quantity = 0
##		return_item = items[index].stack(item, int(item.quantity / 2.0))
##	else:
##		items[index] = null
##		return_item = item
##
##	updated.emit(self)
##	return return_item
#
#func item_pull(index: int, grabbed_item: Item, quantity: int) -> Item:
#	var item := items[index]
#
#	var return_item: Item
#	if not item:
#		items[index] = grabbed_item.duplicate()
#		items[index].quantity = 0
#		return_item = items[index].stack(grabbed_item, quantity)
#		updated.emit(self)
#		return return_item
#
#	if item.can_be_stacked_with(grabbed_item):
#		return_item = item.stack(grabbed_item, quantity)
#	else:
#		# Items can't stack, swap them instead
#		items[index] = grabbed_item
#		return_item = item
#
#	updated.emit(self)
#	return return_item
#
#func item_pull_max(index: int, grabbed_item: Item) -> Item:
#	return item_pull(index, grabbed_item, grabbed_item.quantity)

func item_use(index: int) -> void:
	var item := items[index]
	
	if not item:
		return
	
	if item.use():
		for i in item.get_reference_count():
			item.unreference()
	
	updated.emit(self)

func _is_item_blacklisted(p_item: Item) -> bool:
	return item_blacklist.any(func(type): return is_instance_of(p_item, type))
