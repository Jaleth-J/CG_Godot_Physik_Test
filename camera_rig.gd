extends Node3D

@export var target: Node3D
@export var follow_speed := 5.0
@export var offset := Vector3(0, 3, -6)

func _process(delta):
	if not target:
		return

	var desired_position = target.global_transform.origin + offset
	global_transform.origin = global_transform.origin.lerp(desired_position, delta * follow_speed)

	# Kamera immer ausrichten
	look_at(target.global_transform.origin + Vector3(0, 1, 0), Vector3.UP)adaad
