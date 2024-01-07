extends CharacterBody2D

var SPEED = 50
var GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity") # Get the GRAVITY from the project settings to be synced with RigidBody nodes.

var player
var direction
var chase_flag = false # Not chasing the player if false

@onready var frog_animation = get_node("AnimatedSprite2D")

# Detect the player entering area
func _on_player_detection_area_body_entered(body):
	if body.name == "Player": # If player is detected
		chase_flag = true
		player = get_node("../../Player/Player")

# Detect the player exiting area
func _on_player_detection_area_body_exited(body):
	if body.name == "Player": # If player is detected
		chase_flag = false
		player = get_node("../../Player/Player")

func _physics_process(delta):
	# Add GRAVITY
	self.velocity.y += GRAVITY * delta
	var v2 = GRAVITY - 2

	print("DIRECTION: ")
	print(direction)
	print("SELF: ", str(self.position))
	
	# Check if we need to chase the player
	if chase_flag == true:
		# Determine direction to player
		player = get_node("../../Player/Player")
		
		print("self pre: ", str(self.position))
		print("pre: ", str(player.position))
		
		print("self pre N: ", str(self.position.normalized()))
		print("pre N: ", str(player.position.normalized()))
		direction = self.position-player.position.normalized() 
		
		print("self post: ", str(self.position))
		print("pre: ", str(player.position))
		print("DIRECTIONNNN: ")
		print(direction)
		var d2 = self.position-player.position
		print("DDDDDDD: ")
		print(d2)
		
		if direction.x > 0: # On the right of the player
			get_node("AnimatedSprite2D").flip_h = true
			#self.velocity.x = direction.x * SPEED
		elif direction.x < 0: # On the left of the player
			get_node("AnimatedSprite2D").flip_h = false
			#self.velocity.x = direction.x * SPEED
	else:
		self.velocity.x = 0
		get_node("AnimatedSprite2D").play("Idle")
	move_and_slide()
