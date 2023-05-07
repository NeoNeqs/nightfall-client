extends Item
class_name Spell

@export var cooldown: float = 0

func use() -> float:
	return cooldown
