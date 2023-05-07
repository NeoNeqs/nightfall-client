extends BoxContainer
class_name UIElement

var _pressed := false

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			_pressed = event.pressed
	elif event is InputEventMouseMotion:
		if not _pressed:
			return
		
		position += event.relative
		position.x = clampf(position.x, 0, get_tree().root.size.x - size.x)
		position.y = clampf(position.y, 0, get_tree().root.size.y - size.y)
