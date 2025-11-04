extends Area2D

@onready var anim: AnimatedSprite2D = $ON

func _ready() -> void:
	# Make sure the saw is animating (uses whichever animation is set as current)
	if anim:
		anim.play()
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	# Your player script has `class_name PlayerController`
	if body is PlayerController:
		# Defer reload to avoid physics-callback warnings
		get_tree().call_deferred("reload_current_scene")
