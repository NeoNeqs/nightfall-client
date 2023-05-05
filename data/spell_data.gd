extends ActionData
class_name SpellData

@export var cooldown: float = 0

@export var timer := Timer.new()

func use() -> int:
	return cooldown
