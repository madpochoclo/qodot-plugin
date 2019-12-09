class_name QodotBuildBrushStaticBodies
extends QodotBuildCollision

func get_name() -> String:
	return "brush_static_bodies"

func get_type() -> int:
	return self.Type.PER_BRUSH

func get_finalize_params() -> Array:
	return ['brush_static_bodies']

func get_wants_finalize():
	return true

func _run(context):
	var entity_idx = context['entity_idx']
	var brush_idx = context['brush_idx']
	var entity_properties = context['entity_properties']

	if not 'classname' in entity_properties:
		return null

	if entity_properties['classname'].find('trigger') != -1:
		return null

	if entity_properties['classname'] == 'func_illusionary':
		return null

	return ["nodes", get_brush_attach_path(entity_idx, brush_idx), [], entity_properties]

func _finalize(context) -> void:
	var brush_static_bodies = context['brush_static_bodies']

	for brush_collision_idx in range(0, brush_static_bodies.size()):
		var brush_collision_data = brush_static_bodies[brush_collision_idx]

		var entity_properties = brush_collision_data[3]
		var brush_static_body = StaticBody.new()
		brush_static_body.name = "CollisionObject"

		brush_static_bodies[brush_collision_idx][2] = [brush_static_body]
