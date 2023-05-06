extends RefCounted
class_name ItemDB

static var _db := {}

const _locations := [
	&"res://game/items/"
]

static func _static_init() -> void:
	ItemDB._load_items()

static func get_item(p_item_id: String) -> Item:
	if p_item_id in _db:
		return _db[p_item_id].duplicate()
	return null

static func _load_items() -> void:
	var files: PackedStringArray
	var resource
	
	for location in _locations:
		files = DirAccess.get_files_at(location)
		
		for file in files:
			resource = load(location.path_join(file))

			if not resource is Item:
				continue
			
			var item: Item = resource
			if not ItemDB._is_item_valid(item):
				continue

			if item.id in _db:
				# TODO: log
				# error-crash ?
				continue
			
			_db[item.id] = resource

# TODO: move this to unit tests
static func _is_item_valid(p_item: Item) -> bool:
	if not p_item.quantity == 1:
		return false
	
	if p_item.icon == null:
		return false

	return true
