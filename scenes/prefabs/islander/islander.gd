extends Node3D
class_name Islander


const SCENE_PATH: String = "res://scenes/prefabs/islander/islander.tscn"

var data: IslanderData

@onready
var mesh_instance: IslanderMesh = %IslanderMesh


func _ready() -> void:
	mesh_instance.set_mesh_path(data.get_mesh_res_path())


static func create_scene() -> Islander:
	var packed_scene : PackedScene = load(SCENE_PATH)
	return packed_scene.instantiate() as Islander
