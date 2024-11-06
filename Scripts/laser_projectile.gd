extends Area2D

@export var speed : float = 400.0
@export var rect_size : Vector2 = Vector2(4, 20)
@export var damage : int = 10

var direction : Vector2 = Vector2.ZERO

func _ready() -> void:
	add_to_group("projectiles")
	var shape = RectangleShape2D.new()
	shape.extents = rect_size / 2.0
	$CollisionShape2D.shape = shape

func set_target_direction(target_direction: Vector2):
	direction = target_direction.normalized()
	rotation = direction.angle() + PI / 2
	
func _process(delta: float) -> void:
	if direction != Vector2.ZERO:
		position += direction * speed * delta
		
	if is_out_of_bounds():
		queue_free()
		
		
func is_out_of_bounds() -> bool:
	return position.x < -50 or position.x > 1050 or position.y < -50 or position.y > 1050

func _draw() -> void:
	draw_rect(Rect2(-rect_size.x / 2, -rect_size.y / 2, rect_size.x ,rect_size.y), Color(0,1,0),true)
	
	
	
