extends Camera3D

var rotating := false
var drag_start := Vector2()
var yaw := 0.0
var pitch := 0.0
@export var sensitivity := 0.005
@export var distance := 10.0
@export var orbit_center := Vector3(0, 0, 0)

func _ready():
	var dir = (global_transform.origin - orbit_center).normalized()
	yaw = rotation_degrees.y
	pitch = rotation_degrees.x

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_MIDDLE:
			rotating = event.pressed
			if rotating:
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			else:
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	if rotating and event is InputEventMouseMotion:
		yaw -= event.relative.x * sensitivity * 100
		pitch -= event.relative.y * sensitivity * 100
		pitch = clamp(pitch, -89, 89)

func _process(delta):
	var x_rad = deg_to_rad(pitch)
	var y_rad = deg_to_rad(yaw)

	var cam_offset = Vector3(
		distance * sin(y_rad) * cos(x_rad),
		distance * sin(x_rad),
		distance * cos(y_rad) * cos(x_rad)
	)

	global_transform.origin = orbit_center + cam_offset
	look_at(orbit_center, Vector3.UP)
