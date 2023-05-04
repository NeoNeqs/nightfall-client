extends RefCounted
class_name Messages

const ITEM_DATA_INVALID_ID_FORMAT := "Inavlid id format: '%s'. The correct format is \
'identifier:identifier. A valid identifier may contain only letters, digits and \
underscores (_), and the first character may not be a digit."

const SLOT_DATA_MAX_CAPACITY_EXCEEDED := "Max capacity (%d) of '%s' was exceeded."

const SLOT_DATA_NO_QUANTITY := "Assigned quantity (%d) of '%s' is invalid. \
Make sure quantity > 0. Setting quantity to %d."

const ITEM_DATA_INVALID_MAX_CAPACITY := "Max capacity of '%s' must be at least %d. \
Setting max_capacity to %d"

const SLOT_DATA_NO_ITEM_DATA := "A SlotData (%s) must have a ActionData assigned to it to work properly."
