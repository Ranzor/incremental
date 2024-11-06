extends Node2D

@export var enemy_spawn_rate: float = 2.0
@export var enemy_distance_range: float = 400.0
@export var spawn_decrease_rate : float = 0.1
@export var minimum_spawn_rate : float = 0.5

var enemy_spawn_timer : Timer
var difficulty_timer : Timer

func _ready():
	enemy_spawn_timer = Timer.new()
	enemy_spawn_timer.wait_time = enemy_spawn_rate
	enemy_spawn_timer.autostart = true
	enemy_spawn_timer.one_shot = false
	add_child(enemy_spawn_timer)
	enemy_spawn_timer.connect("timeout", Callable(self,"spawn_enemy"))
	
	difficulty_timer = Timer.new()
	difficulty_timer.wait_time = 10.0
	difficulty_timer.autostart = true
	difficulty_timer.one_shot = false
	add_child(difficulty_timer)
	difficulty_timer.connect("timeout", Callable(self, "increase_difficulty"))
	
	
func spawn_enemy() -> void:
	var enemy_instance = preload("res://scenes/circle_enemy.tscn").instantiate()
	
	var random_angle = randf() * PI * 2
	var spawn_offset = Vector2(cos(random_angle), sin(random_angle)) * enemy_distance_range
	enemy_instance.position = $PlayerShip.position + spawn_offset
	
	add_child(enemy_instance)

func increase_difficulty() -> void:
	if enemy_spawn_rate > minimum_spawn_rate:
		enemy_spawn_rate = max(enemy_spawn_rate - spawn_decrease_rate, minimum_spawn_rate)
		enemy_spawn_timer.wait_time = enemy_spawn_rate
