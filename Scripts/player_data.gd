extends Node

var upgrade_points : int = 0

var fire_rate : float = 1.0
var fire_rate_cost : int = 10

var max_health : int = 20
var max_health_cost : int = 10

var damage : int = 10
var damage_cost : int = 10

var multi_shot_level : int = 0
var multi_shot_cost : int = 10

func reset() -> void:
	fire_rate = 1.0
	max_health = 100
	damage = 10
	multi_shot_level = 0
