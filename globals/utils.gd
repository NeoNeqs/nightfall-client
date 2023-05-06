extends RefCounted
class_name Utils

static func is_valid_item_id(p_id: String) -> bool:
	if p_id.length() == 0:
		return false
	
	var segments := p_id.split(':', true)
	if not segments.size() == 2:
		return false
	
	for segment in segments:
		if not segment.is_valid_identifier():
			return false
	
	return true
