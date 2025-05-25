extends RefCounted
class_name IslanderData

var id: String
var profile: IslanderProfile
var state: IslanderState
var mesh: Mesh

# TODO: Store inventory, relationships, history

func get_mesh_res_path() -> String:
	match profile.life_stage:
		IslanderProfile.LifeStage.BABY, IslanderProfile.LifeStage.CHILD:
			return MeshData.BODY_BABY_MESH
		IslanderProfile.LifeStage.TEENAGER:
			return MeshData.BODY_YOUNG_MESHES[profile.young_body_type]
		_:
			return MeshData.BODY_MESHES[profile.body_type]

func update_state(delta: float) -> void:
	state.update(profile.personality, delta)
