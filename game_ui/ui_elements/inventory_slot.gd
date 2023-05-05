extends PanelContainer
class_name InventorySlot

signal clicked(index: int, button_index: int)

func set_data(p_slot_data: SlotData) -> void:
	$ItemVisualizer.texture = p_slot_data.action_data.icon
	
	if p_slot_data.quantity > 1:
		$QuantityVisualizer.text = "x%d" % [p_slot_data.quantity]
	else:
		$QuantityVisualizer.text = ""

func _gui_input(event: InputEvent) -> void:
	if not event is InputEventMouseButton:
		return
	
	if not event.is_pressed():
		return
	
	if event.button_index in [MOUSE_BUTTON_LEFT, MOUSE_BUTTON_RIGHT]:
		clicked.emit(get_index(), event.button_index)
