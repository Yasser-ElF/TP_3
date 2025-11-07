extends CharacterBody2D
class_name PlayerController

# rendre les variables modifiables directement dans l'editeur godot
@export var speed = 10.0  # la vitesse du joueur, modifiable dans l'editeur
@export var jump_power = 10.0  # la puissance du saut, modifiable dans l'editeur

# creation des variables internes pour la gestion des mouvements et des multipliers
var speed_multiplier = 30.0  # controler la rapidite du mouvement
var jump_multiplier = -30.0  #controler la hauteur du saut (negatif pour aller vers le haut)
var direction = 0  # la direction du mouvement sera utilisee pour l'axe x (g/d)
var was_on_floor = false
var DustScene := preload("res://platformer_tp3/assets/scenes/dust.tscn")

# initialiser les variables pour les effets sonores une fois la scene prete
@onready var jump_sfx: AudioStreamPlayer2D = $son/jumpSfx  #au son de saut
@onready var fall_sfx: AudioStreamPlayer2D = $son/fallSfx  #au son de chute
@onready var marche_sfx: AudioStreamPlayer2D = $son/marcheSfx  #au son de marche

# recuperer la valeur de la gravite par defaut du moteur physique 2d definie dans les parametres du projet
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")  # gravite du monde 2d

# fonction qui gere les entrees du joueur, comme le saut et la descente a travers les plateformes
func _input(event):
	# verifier si l'action "jump" est pressee et si le joueur est sur le sol
	if event.is_action_pressed("jump") and is_on_floor():
		# applique une impulsion verticale pour le saut
		velocity.y = jump_power * jump_multiplier  # la vitesse verticale devient _ pour aller vers le haut
		jump_sfx.play()  

	# verifier si la touche "ui_down" est pressee
	if event.is_action_pressed("ui_down"):
		# desactive la collision avec le layer 10
		set_collision_mask_value(10, false)
	else:
		# reactive la collision avec le layer 10
		set_collision_mask_value(10, true)

# fonction de mise a jour physique, appelee a chaque frame
func _physics_process(delta):
	var just_landed = is_on_floor() and not was_on_floor
	if just_landed:
		var dust = DustScene.instantiate()
		dust.global_position = global_position + Vector2(0, 8) # shift to feet height if needed
		get_tree().current_scene.add_child(dust)
		# Update landing memory
	was_on_floor = is_on_floor()

	# gerer la gravite  si le joueur nest pas sur le sol appliquer la gravite
	if not is_on_floor():
		# applique la gravite a la vitesse verticale (velocity.y) pendant le temps ecoule
		velocity.y += gravity * delta  # la gravite est appliquee sur laxe Y
		fall_sfx.play()  

	# gerer les mouvements horizontaux du joueur : direction gauche/droite
	direction = Input.get_axis("move_left", "move_right")  # obtient la direction du mouvement (g/d)

	if direction:  # si une direction est donnee
		# deplace le joueur a la vitesse specifiee
		velocity.x = direction * speed * speed_multiplier
	else:
		# si aucune direction n'est donnee (le joueur est a l'arret) ralentit le mouvement horizontal
		velocity.x = move_toward(velocity.x, 0, speed * speed_multiplier)
		marche_sfx.play()

	#  Run sound logic
	if is_on_floor() and direction != 0:
		if not marche_sfx.playing:
			marche_sfx.play()
	else:
		if marche_sfx.playing:
			marche_sfx.stop()
	
	move_and_slide()  # deplace le personnage en fonction de la vitesse et de la direction definies


func _on_resume_pressed() -> void:
	pass # Replace with function body.
