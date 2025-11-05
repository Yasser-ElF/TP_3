extends Area2D

func _ready() -> void:
		body_entered.connect(_on_body_entered)
	
func _on_body_entered(body: Node) -> void:
	if body is PlayerController:
		# Defer reload to avoid physics-callback warnings
		get_tree().call_deferred("reload_current_scene")
