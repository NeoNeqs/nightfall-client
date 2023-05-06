extends CharacterBody3D
class_name Character

signal inventory_toggled()

@onready var pivot: Node3D = $Pivot
@onready var model: MeshInstance3D = $MeshInstance3D

@export var inventory_data: InventoryData:
	get: return $InventoryComponent.inventory_data
	set(value): $InventoryComponent.inventory_data = value

const SPEED = 15.0
const JUMP_VELOCITY = 12.0
const LERP = 7.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity") * 3

func _ready() -> void:
	var health_potion := ItemDB.get_item("nf:health_potion")
	health_potion.quantity = 20
	
	inventory_data.add_item(
		health_potion
	)

func _unhandled_key_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("toggle_inventory"):
		inventory_toggled.emit()

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	# Move towards where the camera points to
	direction = direction.rotated(Vector3.UP, pivot.rotation.y)
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		
		# Interpolate from model look dir to character look dir
		var model_rotation := Quaternion(model.transform.basis)
		var character_rotatation := Quaternion(
			Basis(Vector3.UP, atan2(-velocity.x, -velocity.z))
		)
		model.transform.basis = Basis(
			model_rotation.slerp(character_rotatation, LERP * delta)
		).orthonormalized()
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	move_and_slide()
