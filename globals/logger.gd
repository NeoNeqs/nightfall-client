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
		print_rich("[color=yellow]%s[/color]" % [p_message])
		push_warning(p_message)
	else:
		print(p_message)
	Logger._print_callstack()

static func error(p_message: String) -> void:
	#var time := Time.get_datetime_dict_from_system()
	printerr(p_message)
	
	if OS.is_debug_build():
		push_error(p_message)
		@warning_ignore("assert_always_false")
		assert(false, p_message)
	
	Logger._print_callstack()

static func _print_callstack() -> void:
	if not OS.is_stdout_verbose():
		return
	
	for _call in get_stack():
		print_rich(
			"\tat: [color=cyan]%s[/color]:[color=lime]%d[/color] \
([color=yellow]%s[/color])" % [_call.function, _call.line, _call.source])
