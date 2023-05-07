extends InventorySlot
class_name DragSlot

var source_inventory_data: InventoryData = null
var source_index: int = -1
var source_item: Item = null
func _ready() -> void:
	move_to_front.call_deferred()

func _physics_process(_delta: float) -> void:
	_grabbed_slot_follow_mouse()


func update() -> void:
	if source_item:
		show()
		set_item(source_item)
		return

	hide()

func _grabbed_slot_follow_mouse():
	var upper_bound: Vector2 = Vector2(get_tree().root.size) - size

	global_position = get_global_mouse_position() - (size / 2)
	global_position.x = clamp(global_position.x, 0, upper_bound.x)
	global_position.y = clamp(global_position.y, 0, upper_bound.y)
