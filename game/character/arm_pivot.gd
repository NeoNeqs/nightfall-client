extends Node3D
@onready var spring_arm_3d: SpringArm3D = $SpringArm3D

var sens := 0.005

var pressed := false

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			pressed = event.pressed
	elif event is InputEventMouseMotion:
		if not pressed:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			return
		
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		rotate_y(-event.relative.x * sens)
		spring_arm_3d.rotate_x(-event.relative.y * sens)
		spring_arm_3d.rotation.x = clamp(spring_arm_3d.rotation.x, -PI/2, 0.785398)
#		rotation_degrees.x -= event.relative.y * sens-PI / 4
#		rotation_degrees.x = clamp(rotation_degrees.x, -90.0, 30.0)
#
#		rotation_degrees.y -= event.relative.x * sens
#		rotation_degrees.y = wrapf(rotation_degrees.y, 0.0, 360.0)
