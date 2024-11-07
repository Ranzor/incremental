extends Area2D

@export var fire_rate: float = 1.0
@export var max_health : int = 100
var current_health : int = max_health

@export var damage : int = 10
@export var multi_shot_level : int = 0


@export var triangle_size : float = 20.0
@export var rotation_speed : float = 3.0
@export var rotation_tolerance : float = 0.05

@export var filled : bool = false

var target_direction : Vector2 = Vector2.ZERO
var points
var is_aligned : bool = false

func _ready() -> void:
	fire_rate = PlayerData.fire_rate
	print("Fire Rate: " + str(fire_rate))
	max_health = PlayerData.max_health
	print("Max Health: " + str(max_health))
	current_health = max_health
	damage = PlayerData.damage
	print("Damage : " + str(damage))
	multi_shot_level = PlayerData.multi_shot_level	
	
	add_to_group("players")
	points = [ 
		Vector2(0, -triangle_size), 
		Vector2(-triangle_size * 0.75, triangle_size), 
		Vector2(triangle_size * 0.75, triangle_size) ]
		
	var shape = ConvexPolygonShape2D.new()
	shape.points = points
	$CollisionShape2D.shape = shape
	
	var shoot_timer = Timer.new()
	shoot_timer.wait_time = fire_rate
	shoot_timer.autostart = true
	shoot_timer.one_shot = false
	add_child(shoot_timer)
	shoot_timer.connect("timeout", Callable(self, "attempt_shoot"))

func _process(delta: float) -> void:
	var enemies = get_tree().get_nodes_in_group("enemies")
	if enemies.is_empty():
		target_direction = Vector2.ZERO
	else:
		var closest_enemy = null
		var closest_distance = INF		
		
		for enemy in enemies:
			var distance = position.distance_to(enemy.position)
			if distance < closest_distance:
				closest_distance = distance
				closest_enemy = enemy
				
		if closest_enemy:
			target_direction = (closest_enemy.position - position).normalized()		
		
	
	if target_direction != Vector2.ZERO:
		var target_rotation = target_direction.angle() + PI / 2
		rotation = lerp_angle(rotation,target_rotation,rotation_speed * delta)
		
		if abs(angle_difference(rotation,target_rotation)) < rotation_tolerance:
			is_aligned = true
		else:
			is_aligned = false


func take_damage(damage : int ) -> void:
	current_health -= damage
	if current_health <= 0:
		die()
		
func die() -> void:
	print("Game Over! The player has died")
	print("Upgrade Points: " + str(PlayerData.upgrade_points))
	get_tree().change_scene_to_file("res://scenes/upgrade_menu.tscn")

func attempt_shoot() -> void:
	if is_aligned:
		shoot_projectile()

func shoot_projectile():		
	var projectile_instance = preload("res://scenes/laser_projectile.tscn").instantiate()
	projectile_instance.position = position
	get_parent().add_child(projectile_instance)	
	projectile_instance.set_target_direction(target_direction)
	projectile_instance.damage = damage


func _draw() -> void:
	
	if filled:
		draw_polygon(points, [Color(1,1,1)])
	else:
		draw_polyline(points + [points[0]],Color(1,1,1),2.0)
