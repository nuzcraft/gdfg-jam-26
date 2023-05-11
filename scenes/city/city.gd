extends Node2D

@export var health: int
signal city_damaged

func _on_area_2d_body_entered(body):
	print(body)
	if body.is_in_group("missile"):
		print("taking damage")
		take_damage()
		body.blow_up()
		
func take_damage():
	health -= 10
	city_damaged.emit(health)
	
