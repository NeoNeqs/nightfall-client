extends PanelContainer
class_name InventorySlot

signal clicked(index: int, button_index: int)

func set_item(p_item: Item) -> void:
	$ItemVisualizer.texture = p_item.icon
	
	if p_item.quantity > 1:
		$QuantityVisualizer.text = "x%d" % [p_item.quantity]
	else:
		$QuantityVisualizer.text = ""

func _gui_input(event: InputEvent) -> void:
	if not event is InputEventMouseButton:
		return
	
	if not event.is_pressed():
		return
	
	if event.button_index in [MOUSE_BUTTON_LEFT, MOUSE_BUTTON_RIGHT]:
		clicked.emit(get_index(), event.button_index)
