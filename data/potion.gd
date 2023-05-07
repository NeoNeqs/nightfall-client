extends Item
class_name Potion

@export var restore_amount: int

func use() -> bool:
	quantity -= 1
	
	return quantity <= 0
	
