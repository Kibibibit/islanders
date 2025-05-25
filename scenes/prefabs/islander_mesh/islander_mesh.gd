extends Node3D
class_name IslanderMesh


@onready
var mesh_instance: MeshInstance3D = %IslanderMeshInstance

var mesh_path: String
var mesh: Mesh


func _ready() -> void:
	if not mesh_path.is_empty():
		_load_mesh()
	

func set_mesh_path(_path: String) -> void:
	if (_path != mesh_path):
		mesh_path = _path
		_load_mesh()

func _load_mesh() -> void:
	mesh = load(mesh_path)
	mesh_instance.mesh = mesh
