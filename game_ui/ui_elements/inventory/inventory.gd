extends PanelContainer
class_name Inventory

@onready 
var item_grid := $Margin/ItemGrid as GridContainer

# Note: This function is being run every time inventory is updated.
#       Deleting, instantiating and readding might be slow for larger inventories.
# TODO: Create a function that can fill information from InventoryData into
#       already existing slots
func fill_item_grid(p_inventory_data: InventoryData) -> void:
	for child in item_grid.get_children():
		child.queue_free()
	
	item_grid.columns = p_inventory_data.columns
	for slot_data in p_inventory_data.slot_data:
		var slot := create_slot()
		item_grid.add_child(slot)
		
		slot.clicked.connect(p_inventory_data.on_slot_clicked)
		if not slot_data:
			continue
		
		slot.set_data(slot_data)

func create_slot() -> InventorySlot:
	const slot_scene := preload("res://game_ui/ui_elements/inventory_slot.tscn")
	return slot_scene.instantiate()
