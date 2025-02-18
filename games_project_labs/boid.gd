class_name Boid extends CharacterBody3D

var v:Vector3
var acceleration:Vector3
var force:Vector3

@export var max_speed:float=10
@export var mass:float=1

@export var target_node_path:NodePath

var target_pos

func _ready():
	var t = get_node(target_node_path)
	target_pos = t.position
	
func seek(target):
	var to_target:Vector3 = target - position
	var desired = to_target.normalized() * max_speed
	return desired - v

func _physics_process(delta):
	force = seek(target_pos)
	acceleration = force / mass
	v += acceleration * delta
	
	var speed = v.length()
	if speed > 0:
		look_at(position - v)
	move_and_collide(v * delta)
	
