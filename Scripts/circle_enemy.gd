extends Area2D

@export var speed : float = 50.0
@export var radius : float = 15.0
@export var damage: int = 10
@export var max_health: int = 20
var current_health = max_health


func _ready() -> void:
	add_to_group("enemies")
	
	var shape = CircleShape2D.new()
	shape.radius = radius
	$CollisionShape2D.shape = shape

func _process(delta: float) -> void:
	var direction = ($"../PlayerShip".position - position).normalized()
	position += direction * speed * delta

func take_damage(damage) -> void:
	current_health -= damage
	if current_health <= 0:
		queue_free()

func _draw() -> void:
	draw_circle(Vector2(0,0), 15, Color(1,0,0),true)


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("projectiles"):
		take_damage(area.damage)
		area.queue_free()
	
	if area.is_in_group("players"):
		print("hit the dude!")
		area.take_damage(damage)
		queue_free()
