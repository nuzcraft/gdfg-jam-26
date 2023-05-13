extends Node2D

@onready var city = $City
@onready var health_label = $Control/HealthLabel
@onready var missile_timer = $MissileTimer
@onready var timer_label = $Control/TimerLabel

var missile_scene = preload("res://scenes/missile/missile.tscn")

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	spawn_missile_wave()
	health_label.text = "Health: %d" % city.health 

func spawn_missile_wave():
	var screen_width = 1152
	var screen_segments = 8
	var segment_width = screen_width / screen_segments
	var chance_per_segment = 0.5
	for i in range(screen_segments):
		if rng.randf() <= chance_per_segment:
			var missile = missile_scene.instantiate()
			var position_in_segment = rng.randf() * segment_width
			var y_position = rng.randf() * -80 - 70
			missile.position = Vector2((i*segment_width) + position_in_segment, y_position)
			var target: Vector2 = Vector2(rng.randf_range(204.0, 948.0), 618)
	#		missile.rotation = PI
	#		print(missile.position.angle_to_point(target))
			missile.rotation = (PI / 2) + missile.position.angle_to_point(target)
			add_child(missile)

func _on_missile_timer_timeout():
	get_tree().call_group("missile", "speed_up")
	$WaitTimer.start()

func _on_wait_timer_timeout():
	get_tree().call_group("missile", "blow_up")
	spawn_missile_wave()
	$MissileTimer.start()

func _on_city_city_damaged(health):
	health_label.text = "Health: %d" % health
	
func _process(delta):
	if missile_timer.is_stopped():
		timer_label.visible = false
	else:
		timer_label.visible = true
		timer_label.text = str(int(missile_timer.time_left) + 1)
