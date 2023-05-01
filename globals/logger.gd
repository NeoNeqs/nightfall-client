extends RefCounted
class_name Logger

enum Level {
	DEBUG,
	INFO,
	WARNING,
	ERROR
}

static func debug(p_variant: Variant) -> void:
	if OS.is_debug_build():
		print(p_variant)

static func info(p_message: String) -> void:
	print(p_message)

static func warning(p_message: String) -> void:
	if OS.is_debug_build():
		push_warning(p_message)
	else:
		print(p_message)
	Logger._print_callstack()

static func error(p_message: String) -> void:
	#var time := Time.get_datetime_dict_from_system()
	if OS.is_debug_build():
		@warning_ignore("assert_always_false")
		assert(false, p_message)
		return
	
	print(p_message)
	Logger._print_callstack()

static func _print_callstack() -> void:
	for _call in get_stack():
		print("at: %s:%d (%s)" % [_call.function, _call.line, _call.source])
