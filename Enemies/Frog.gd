extends CharacterBody2D

var SPEED = 50

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player
var direction
var chase_flag = false # Not chasing the player if false

@onready var frog_animation = get_node("AnimatedSprite2D")

# Detect the player entering area
func _on_player_detection_area_body_entered(body):
	if body.name == "Player": # If player is detected
		chase_flag = true

# Detect the player exiting area
func _on_player_detection_area_body_exited(body):
	if body.name == "Player": # If player is detected
		chase_flag = false

func _physics_process(delta):
	# Add gravity
	velocity.y += gravity * delta
	
	# Check if we need to chase the player
	if chase_flag == true:
		# Determine direction to player
		player = get_node("../../Player/Player")
		direction = (player.position - self.position).normalized() 
	
		if direction.x > 0: # On the right of the player
			get_node("AnimatedSprite2D").flip_h = true
			velocity.x = direction.x * SPEED
		elif direction.x < 0: # On the left of the player
			get_node("AnimatedSprite2D").flip_h = false
			velocity.x = direction.x * SPEED
	else:
		velocity.x = 0
	move_and_slide()
