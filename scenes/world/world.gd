extends Node2D

var missile_scene = preload("res://scenes/missile/missile.tscn")
@onready var city = $City
@onready var health_label = $Control/HealthLabel
@onready var missile_timer = $MissileTimer
@onready var timer_label = $Control/TimerLabel

func _ready():
	spawn_missile_wave()
	health_label.text = "City Health: %d" % city.health 

func spawn_missile_wave():
	for i in range(4):
		var missile = missile_scene.instantiate()
		missile.position = Vector2(137 + (i * 300), -78)
		missile.rotation_degrees = 180
		add_child(missile)

func _on_missile_timer_timeout():
	get_tree().call_group("missile", "speed_up")
	$WaitTimer.start()

func _on_wait_timer_timeout():
	get_tree().call_group("missile", "blow_up")
	spawn_missile_wave()
	$MissileTimer.start()

func _on_city_city_damaged(health):
	health_label.text = "City Health: %d" % health
	
func _process(delta):
	if missile_timer.is_stopped():
		timer_label.visible = false
	else:
		timer_label.visible = true
		timer_label.text = str(int(missile_timer.time_left) + 1)
