extends CharacterBody2D

var SPEED = 50
var GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity") # Get the GRAVITY from the project settings to be synced with RigidBody nodes.

var player
var direction
var chase_flag = false # Not chasing the player if false

@onready var frog_animation = get_node("AnimatedSprite2D")

# Setup the frog
func _ready():
	get_node("AnimatedSprite2D").play("Idle")

# Detect the player entering area
func _on_player_detection_area_body_entered(body):
	if body.name == "Player": # where does godot install linuxIf player is detected
		chase_flag = true

# Detect the player exiting area
func _on_player_detection_area_body_exited(body):
	if body.name == "Player": # If player is detected
		chase_flag = false

#Check ea
func _on_player_detection_area_for player collision/kill
func _on_player_death_area_body_entered(body):
	if body.name == "Player": #Player is colliding with hitbox
		get_node("AnimatedSprite2D").play("Death")
		await get_node("AnimatedSprite2D").animation_finished
		self.queue_free() #Delete the frog

func _physics_process(delta):
	# Add GRAVITY
	self.velocity.y += GRAVITY * delta
	self.velocity.x = 0
	chase_flag = false
	
	# Check if we need to chase the player
	if chase_flag == true:
		# Determine direction to player
		player = get_parent().get_node("Player")
		
		# Convert positions to global coordinates
		var self_global_position  = self.position
		var player_global_position = player.position

		direction = (player_global_position - self_global_position).normalized()
		
		if get_node("AnimatedSprite2D").animation != "Death":
			if direction.x > 0: # On the right of the player (sprite faces left by default)
				get_node("AnimatedSprite2D").flip_h = true
				#self.velocity.x = direction.x * SPEED
			elif direction.x < 0: # On the left of the player
				get_node("AnimatedSprite2D").flip_h = false
				#self.velocity.x = direction.x * SPEED
			get_node("AnimatedSprite2D").play("Jump")
			self.velocity.x = direction.x * SPEED
	else:
		if get_node("AnimatedSprite2D").animation != "Death":
			get_node("AnimatedSprite2D").play("Idle")
		self.velocity.x = 0 
		
	move_and_slide()
