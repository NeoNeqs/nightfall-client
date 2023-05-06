extends PanelContainer
class_name Inventory

@onready 
var item_grid := $Margin/ItemGrid as GridContainer

# Note: This function is being run every time inventory is updated.
#       Deleting, instantiating and readding might be slow for larger inventories.
# TODO: Create a function that can fill information from InventoryData into
#       already existing slots
func update(p_inventory_data: InventoryData) -> void:
	for child in item_grid.get_children():
		child.queue_free()
	
	item_grid.columns = p_inventory_data.columns
	for item in p_inventory_data.items:
		var slot := create_slot()
		item_grid.add_child(slot)
		
		slot.clicked.connect(p_inventory_data.on_item_clicked)
		if not item:
			continue
		
		slot.set_item(item)

func create_slot() -> InventorySlot:
	const slot_scene := preload("res://game_ui/ui_elements/inventory_slot.tscn")
	return slot_scene.instantiate()
