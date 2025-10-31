extends Area2D



func _ready():
	$AnimatedSprite2D.play("energy_cell")


func _on_body_entered(body):
	if body is PlayerController:
		GameManager.add_energy_cell()
		$AudioStreamPlayer.play()
		$CollisionShape2D.call_deferred("set_disabled",true)
		$AnimatedSprite2D.visible = false
