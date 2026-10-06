extends Node3D

const Rules = preload("res://scripts/rules.gd")
var rules = Rules.new()

@onready var walker: CharacterBody3D = $Walker
@onready var goal_mark: MeshInstance3D = $GoalMark

func _physics_process(delta: float) -> void:
	var wish := Vector2(
		Input.get_action_strength("stride_east") - Input.get_action_strength("stride_west"),
		Input.get_action_strength("stride_south") - Input.get_action_strength("stride_north")
	)
	walker.velocity.x = wish.x * 4.0
	walker.velocity.z = wish.y * 4.0
	if Input.is_action_just_pressed("leap"):
		if rules.try_leap():
			walker.velocity.y = 6.0
	if walker.is_on_floor():
		rules.mark_landed()
	else:
		walker.velocity.y -= 14.0 * delta
	walker.move_and_slide()
	var touching_wall := false
	for index in walker.get_slide_collision_count():
		var hit: KinematicCollision3D = walker.get_slide_collision(index)
		if hit.get_normal().y < 0.4:
			touching_wall = true
	if touching_wall and rules.cling(touching_wall, rules.cling_owned) and Input.is_action_just_pressed("leap"):
		walker.velocity.y = 6.0
	if walker.global_position.distance_to(goal_mark.global_position) < 1.2:
		rules.take_goal()
		if rules.goal_taken:
			goal_mark.scale = Vector3(1, 1.4, 1)
		if rules.may_rise():
			_go("res://scenes/rise.tscn")

func _go(next_path: String) -> void:
	rules.grant_cling()
	get_tree().change_scene_to_file(next_path)
