extends CharacterBody2D

# Path to the Minion scene
@export var minion_scene: PackedScene

# Speed of the player
var speed = 200.0

func manual_summon():
	var minion_scene = load("res://scenes/minion.tscn")
	var minion = minion_scene.instantiate()
	if minion == null:
		print("failed to instantiate minion.")
	else:
		minion.global_position = self.global_position + Vector2(50, 0)
		get_parent().add_child(minion)

func summon_minion():
	if minion_scene:
		print("Minion scene loaded correctly")
		# Instance the minion scene
		var minion = minion_scene.instantiate()
		if minion == null:
			print("Failed to instantiate minion.")
		else:
		# Set the position where the minion will be spawn (e.g., near the player)
			minion.global_position = self.global_position + Vector2(50, 0) # Adjust as needed
		
		# Add the minion to the current scene
			get_parent().add_child(minion)
			print("summoned at: ", minion.global_position)
	else:
		print("Minion scene is not assigned.")
func _ready():
	print("ready")
#	summon_minion()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
#	pass
#	print("process is running")
	if Input.is_action_just_pressed("summon_minion"):
#		manual_summon()
		summon_minion()

func _physics_process(delta):
	var direction = Vector2.ZERO

	# Capture movement input
	if Input.is_action_pressed("up"):
		direction.y -= 1
	if Input.is_action_pressed("down"):
		direction.y += 1
	if Input.is_action_pressed("left"):
		direction.x -= 1
	if Input.is_action_pressed("right"):
		direction.x += 1

	# Normalize the input vector so diagonal movement isn't faster
	if direction != Vector2.ZERO:
		direction = direction.normalized()

	# Apply movement by setting the velocity and calling move_and_slide
	velocity = direction * speed
	move_and_slide()
