extends CharacterBody2D

# Detect the player
func _on_player_detection_area_body_entered(body):
	if body.name == "Player": # If player is detected
		print("AAAAAA")
