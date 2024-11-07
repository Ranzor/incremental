extends Control

func _ready() -> void:
	$Panel/VBoxContainer/FireRateButton.connect("pressed", Callable(self,"on_fire_rate_upgrade"))
	$Panel/VBoxContainer/HealthButton.connect("pressed", Callable(self,"on_health_upgrade"))
	$Panel/VBoxContainer/DamageButton.connect("pressed", Callable(self,"on_damage_upgrade"))
	$Panel/VBoxContainer/MultiShotButton.connect("pressed", Callable(self,"on_multi_shot_upgrade"))
	$Panel/VBoxContainer/RestartButton.connect("pressed", Callable(self,"restart"))
	
func on_fire_rate_upgrade() -> void:
	if PlayerData.upgrade_points >= PlayerData.fire_rate_cost:
		PlayerData.upgrade_points -= PlayerData.fire_rate_cost
		PlayerData.fire_rate = max(PlayerData.fire_rate -0.1, 0.2)
		
func on_health_upgrade() -> void:
	if PlayerData.upgrade_points >= PlayerData.max_health_cost:
		PlayerData.upgrade_points -= PlayerData.max_health_cost
		PlayerData.max_health += 20
		
func on_damage_upgrade() -> void:
	if PlayerData.upgrade_points >= PlayerData.damage_cost:
		PlayerData.upgrade_points -= PlayerData.damage_cost
		PlayerData.damage += 10

func on_multi_shot_upgrade() -> void:
	if PlayerData.upgrade_points >= PlayerData.multi_shot_cost:
		PlayerData.upgrade_points -= PlayerData.multi_shot_cost
		PlayerData.multi_shot_level += 1
		
func restart() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")
