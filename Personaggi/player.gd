extends CharacterBody3D

@export_group("Camera")
@export_range(0.0, 1.0) var mouse_sensitivity := 0.25

@export_group("Movement")
@export var move_speed := 8.0
@export var acceleration := 20.0
@export var rotation_speed := 12.0
@export var jump_impulse := 12.0

var _camera_input_direction := Vector2.ZERO
var _last_movement_direction := Vector3.BACK
var move_direction := Vector3.ZERO
var _gravity := -30

@onready var _camera_pivot: Node3D = %CameraPivot
@onready var _camera: Camera3D = %playerCamera3D
@onready var _skin = %SophiaSkin
@onready var own_camera = %playerCamera3D

@onready var actionable_finder: Area3D = $ActionableFinder

@onready var fade = $Fade
var teleporting: bool = false

var old_raw_input := Vector2.ZERO

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		
	if Input.is_action_just_pressed("talk"):
		var actionables = actionable_finder.get_overlapping_areas()
		if actionables.size() >0:
			
			actionables[0].action()
			return

func _unhandled_input(event:InputEvent) -> void:
	var is_camera_motion := (
		event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
	)
	if is_camera_motion:
		_camera_input_direction = event.screen_relative * mouse_sensitivity
		
	

func _physics_process(delta: float) -> void:
	
	if !Global.dialogue_playing:
		_camera_pivot.rotation.x += _camera_input_direction.y * delta
		_camera_pivot.rotation.x = clamp( _camera_pivot.rotation.x, -PI / 6.0, PI / 3.0 )
		_camera_pivot.rotation.y -= _camera_input_direction.x * delta
		

		_camera_input_direction = Vector2.ZERO
		
		
		var raw_input := Input.get_vector("move_left", "move_right", "move_foward", "move_backward")
		var forward : Vector3 = get_viewport().get_camera_3d().global_basis.z
		var right : Vector3 = get_viewport().get_camera_3d().global_basis.x
		
		#non cambiare direzione a cambi di camera improvvisi finché non si ripreme input
		if old_raw_input != raw_input:   
			move_direction = forward * raw_input.y + right * raw_input.x
		elif old_raw_input == Vector2.ZERO:
			move_direction = forward * raw_input.y + right * raw_input.x


		move_direction.y = 0.0
		move_direction = move_direction.normalized()
		
		var y_velocity := velocity.y
		move_direction.y = 0.0
		
		if !teleporting:
			velocity = velocity.move_toward(move_direction * move_speed, acceleration * delta)
			velocity.y = y_velocity + _gravity * delta
			
		
		#TODO metodo migliore e unificare saltare e parlare
		var is_starting_jump: bool
		var actionables = actionable_finder.get_overlapping_areas()
		if Input.is_action_just_pressed("jump"):
			if actionables.size() >0 :
				actionables[0].action()
				print(Global.npc_dict.slasher)
				#TODO ## orribile da togliere appena possibile
				for element in Global.npc_dict : 
					var value = Global.npc_dict[element]
					if value == false :
						print("Non hai ancora finito.")
				return
			elif is_on_floor():
				#TOLTO SALTO EHEH (servono entrambi con il pezzo sotto
				#TODO fixa il portale e il salto che prende il volo
				#se devi rimetterlo metti entrambi
				#is_starting_jump = true
				pass
		if is_starting_jump:
			#TOLTO SALTO EHEH
			#velocity.y += jump_impulse
			pass

		old_raw_input = raw_input
		
		move_and_slide()
		

		
		if move_direction.length() > 0.2:
			_last_movement_direction = move_direction
		var target_angle := Vector3.BACK.signed_angle_to(_last_movement_direction, Vector3.UP)
		_skin.global_rotation.y = lerp_angle(_skin.rotation.y, target_angle, rotation_speed * delta)

		if is_starting_jump:
			_skin.jump()
		elif not is_on_floor() and velocity.y < 0:
			_skin.fall()
		elif is_on_floor():
			var ground_speed := velocity.length()
			if ground_speed > 0.0:
				_skin.move()
			else:
				_skin.idle()
	else:
		move_direction = Vector3.ZERO
		velocity = Vector3.ZERO
		_skin.idle()
