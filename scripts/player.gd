
extends KinematicBody2D
 
var input_direction = 0
var direction = 1
 
var speed_x = 0
var speed_y = 0

const MAX_SPEED = 800
const ACCELERATION = 2000
const DECELERATION = 8000

const JUMP_POWER = 400 
const GRAVITY = 1600

const MAX_JUMP_COUNT = 2

var velocity = Vector2()
 
func _ready():
    set_process(true)
    set_process_input(true)
 
 
func _input(event):
    var move_left = event.is_action_pressed("move_left")
    var move_right = event.is_action_pressed("move_right")
    var stop_moving = not (Input.is_action_pressed("move_right") or Input.is_action_pressed("move_left"))
    var jump = event.is_action_pressed("jump")
   
    if move_left:
        input_direction = -1
    if move_right:
        input_direction = 1
    if stop_moving:
        input_direction = 0
    if jump:
	    speed_y = -JUMP_POWER
	
		
   
    if move_left or move_right and input_direction:
        if input_direction == -1 * direction:
            speed_x /= 3
            direction = input_direction
 
 
func _process(delta):
    if input_direction:
        speed_x += ACCELERATION * delta
    else:
        speed_x -= DECELERATION * delta
    speed_x = clamp(speed_x, 0, MAX_SPEED)

    speed_y += GRAVITY * delta
   
    velocity.x = speed_x * delta * direction
    velocity.y = speed_y * delta
    move(velocity)