extends CharacterBody3D

@export_group("Camera")
@export_range(0.0, 1.0) var mouse_sensitivity := 0.25

var _camera_input_direction := Vector2.ZERO

func _unhandled_input(event:InputEvent) -> void:
	var iscamera_motion := (
		event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
	)

if is_camera_motion:
	_camera_input_direction = event.screen_relative * mouse_sensitivity
