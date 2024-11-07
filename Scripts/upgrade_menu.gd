extends Control

func _ready() -> void:
	$Panel/VBoxContainer/FireRateButton.connect("pressed", Callable(self,"on_fire_rate_upgrade"))
	$Panel/VBoxContainer/HealthButton.connect("pressed", Callable(self,"on_health_upgrade"))
	$Panel/VBoxContainer/DamageButton.connect("pressed", Callable(self,"on_damage_upgrade"))
	$Panel/VBoxContainer/MultiShotButton.connect("pressed", Callable(self,"on_multi_shot_upgrade"))
	$Panel/VBoxContainer/RestartButton.connect("pressed", Callable(self,"restart"))
	set_buttons()
	
func on_fire_rate_upgrade() -> void:
	if PlayerData.upgrade_points >= PlayerData.fire_rate_cost:
		PlayerData.upgrade_points -= PlayerData.fire_rate_cost
		PlayerData.fire_rate = max(PlayerData.fire_rate -0.1, 0.2)
		set_buttons()
		
func on_health_upgrade() -> void:
	if PlayerData.upgrade_points >= PlayerData.max_health_cost:		
		PlayerData.upgrade_points -= PlayerData.max_health_cost
		PlayerData.max_health += 20	
		set_buttons()
		
func on_damage_upgrade() -> void:
	if PlayerData.upgrade_points >= PlayerData.damage_cost:		
		PlayerData.upgrade_points -= PlayerData.damage_cost
		PlayerData.damage += 10
		set_buttons()

func on_multi_shot_upgrade() -> void:
	if PlayerData.upgrade_points >= PlayerData.multi_shot_cost:
		PlayerData.upgrade_points -= PlayerData.multi_shot_cost
		PlayerData.multi_shot_level += 1
		set_buttons()
		
func restart() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")
	
func set_buttons() -> void:
	if PlayerData.upgrade_points >= PlayerData.fire_rate_cost:
		$Panel/VBoxContainer/FireRateButton.disabled = false
	else:
		$Panel/VBoxContainer/FireRateButton.disabled = true
		
	if PlayerData.upgrade_points >= PlayerData.max_health_cost:
		$Panel/VBoxContainer/HealthButton.disabled = false
	else:
		$Panel/VBoxContainer/HealthButton.disabled = true
		
	if PlayerData.upgrade_points >= PlayerData.damage_cost:
		$Panel/VBoxContainer/DamageButton.disabled = false	
	else:
		$Panel/VBoxContainer/DamageButton.disabled = true
	
	if PlayerData.upgrade_points >= PlayerData.multi_shot_cost:
		$Panel/VBoxContainer/MultiShotButton.disabled = false
	else:
		$Panel/VBoxContainer/MultiShotButton.disabled = true
