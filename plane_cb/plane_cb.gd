extends CharacterBody2D


#signal on_plane_died



@onready var animation_player = $AnimationPlayer
@onready var animated_sprite_2d = $AnimatedSprite2D


const GRAVITY: float = 1500.0
const POWER: float = -400.0


var _dead: bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity.y += GRAVITY * delta
	
	fly()
	
	move_and_slide()
	
	if is_on_floor() == true:
		die()


func fly() -> void:
	if Input.is_action_just_pressed("fly") == true:
		velocity.y = POWER
		animation_player.play("fly")


func die() -> void:
	if _dead:
		return
	_dead = true
	animated_sprite_2d.stop() #Stops Animated Sprites Frames
	GameManager.on_game_over.emit()
	set_physics_process(false)
