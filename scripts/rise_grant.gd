extends Node3D

const Rules = preload("res://scripts/rules.gd")

func _ready() -> void:
	var rules = Rules.new()
	rules.grant_cling()
