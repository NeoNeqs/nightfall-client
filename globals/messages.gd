extends RefCounted
class_name Messages

const ITEM_DATA_INVALID_ID_FORMAT := "Inavlid id format: '%s'. The correct format is \
'identifier:identifier. A valid identifier may contain only letters, digits and \
underscores (_), and the first character may not be a digit."

const SLOT_DATA_STACK_SIZE_EXCEEDED := "Max stack size (%d) of '%s' was exceeded."

const SLOT_DATA_NO_QUANTITY := "Assigned quantity (%d) of '%s' is invalid. \
Make sure quantity > 0. Setting quantity to %d."

const ITEM_DATA_INVALID_STACK_SIZE := "Stack size of '%s' must be at least %d. \
Setting stack_size to %d"

const SLOT_DATA_NO_ITEM_DATA := "A SlotData (%s) must have a ItemData assigned to it to work properly."
