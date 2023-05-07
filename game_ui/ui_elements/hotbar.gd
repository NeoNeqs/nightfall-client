extends UIElement

@onready 
var item_grid := $PanelContainer/MarginContainer/GridContainer as GridContainer


# TODO: merge with InventoryWindow

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
