extends RefCounted

var off_ground := false
var goal_taken := false

func try_leap() -> bool:
	if off_ground:
		return false
	off_ground = true
	return true

func mark_landed() -> void:
	off_ground = false

func take_goal() -> void:
	goal_taken = true

var cling_owned := false

func cling(touching_wall: bool, owned: bool) -> bool:
	return touching_wall and owned

func grant_cling() -> void:
	cling_owned = true

func may_rise() -> bool:
	return goal_taken
