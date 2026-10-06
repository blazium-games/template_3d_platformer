extends AutoworkTest

const Rules = preload("res://scripts/rules.gd")

func test_single_leap() -> void:
	var rules = Rules.new()
	assert_true(rules.try_leap(), "first leap")
	assert_false(rules.try_leap(), "air reject")
	rules.mark_landed()
	assert_true(rules.try_leap(), "after landing")

func test_goal_flag() -> void:
	var rules = Rules.new()
	rules.take_goal()
	assert_true(rules.goal_taken, "goal stored")

func test_rise_gate() -> void:
	var rules = Rules.new()
	assert_false(rules.may_rise(), "before goal")
	rules.take_goal()
	assert_true(rules.may_rise(), "after goal")
	assert_true(load("res://scenes/rise.tscn") != null, "rise loads")

func test_cling() -> void:
	var rules = Rules.new()
	assert_false(rules.cling(true, false), "not owned")
	rules.grant_cling()
	assert_true(rules.cling(true, true), "rise grants it")
	assert_false(rules.cling(false, true), "no wall")
