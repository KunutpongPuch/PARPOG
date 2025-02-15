extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var animated = $AnimatedSprite2D
@onready var hitbox = $CollisionShape2D
@onready var hitbox_sneak = $CollisionShape2D2

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("moveLeft", "moveRight")
	
	#flip
	if direction > 0:
		animated.flip_h = false
	elif direction < 0:
		animated.flip_h = true
	else:
		animated.set_frame_and_progress(0, 0)
	
	var sneak := Input.is_action_pressed("sneak")
	
	if sneak:
		animated.set_frame_and_progress(1, 0)
		hitbox.disabled = true
		hitbox_sneak.disabled = false
	else:
		hitbox.disabled = false
		hitbox_sneak.disabled = true
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
